require "csv"

class TasksController < ApplicationController
  before_action :set_driver, except: [:calendar, :new, :create, :generate_csv]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :create_task_type_dropdown
  before_action :create_driver_names_dropdown
  
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  TIME_INTERVALS_IN_DAYS = [2, 4, 7, 14, 28]

  def calendar
    @tasks = Task.all.order(:start_time)
  end

  def index
    @tasks = Task.where(driver: @driver).order(:start_time)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to driver_tasks_url, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to driver_tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_csv
    beginning_of_year = DateTime.current.beginning_of_year
    end_of_year = DateTime.current.end_of_year

    tasks = Task.where(driver_id: params[:id]).pluck(:start_time, :task_type)

    TIME_INTERVALS_IN_DAYS.each do |interval|
      start_day = beginning_of_year
      driver_name = Driver.find(params[:id]).name

      CSV.open("app/reports/#{driver_name}_#{interval}_day_intervals_2020.csv", "w+") do |csv|
        csv << ["Interval"] + Task::VALID_TASK_TYPES
        loop do
          end_day = (start_day + interval.days).end_of_day
          
          data = ["#{start_day.strftime("%B %d")} - #{end_day.strftime("%B %d")}"]
          Task::VALID_TASK_TYPES.each do |type|
            number_of_tasks = tasks.filter{ |task| task[0] >= start_day && task[0] <= end_day && task[1] == type }.count
            data << number_of_tasks
          end
          csv << data

          start_day += interval.days + 1.day
          break if start_day.year > 2020
        end
      end
    end
  end

  private
    def set_driver
      @driver = Driver.find(params[:driver_id])
    end

    def set_task
      @task = Task.where(id: params[:id], driver: @driver).first
    end

    def create_task_type_dropdown
      @task_types = Task::VALID_TASK_TYPES.map{ |task| [task, task] }
    end

    def create_driver_names_dropdown
      @driver_names = Driver.pluck(:name, :id)
    end

    def task_params
      params.require(:task).permit(:task_type, :driver_id, :start_time, :end_time, :description, :location)
    end

    def record_not_found
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
end
