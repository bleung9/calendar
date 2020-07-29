class Task < ApplicationRecord
  belongs_to :driver

  validates_presence_of :task_type, :start_time, :end_time, :description, :location
  validate :valid_type?
  validate :no_overlap
  validate :start_before_end

  VALID_TASK_TYPES = ["pickup", "delivery", "other"]

  def valid_type?
    errors.add(:task_type, "must be a valid type of task") if !VALID_TASK_TYPES.include?(task_type&.downcase)
  end

  def no_overlap
    overlapping_tasks = Task.where('driver_id = ? AND (? BETWEEN start_time AND end_time OR ? BETWEEN start_time AND end_time)', driver_id, start_time, end_time)
    if overlapping_tasks.exists?
      tasks_afterwards = Task.where('driver_id = ? AND ? < end_time', driver_id, start_time).order(:start_time).pluck(:start_time, :end_time)
      tasks_afterwards.each_with_index do |task, i|
        if i == tasks_afterwards.count - 1
          new_start_time = task[1].strftime("%B %d %Y %I:%M%p")
          new_end_time = (task[1] + (end_time - start_time)).strftime("%B %d %Y %I:%M%p")
        elsif (tasks_afterwards[i + 1][0] - task[1]) >= (end_time - start_time)
          new_start_time = task[1].strftime("%B %d %Y %I:%M%p")
          new_end_time = (task[1] + (end_time - start_time)).strftime("%B %d %Y %I:%M%p")
        end

        if new_start_time && new_end_time
          errors.add(:start_time, "or end time overlaps with an existing task. Perhaps #{new_start_time} to #{new_end_time} is better?")
          break
        end
      end
    end
  end

  def start_before_end
    errors.add(:start_time, "must come after end time") if start_time && end_time && start_time >= end_time
  end
end
