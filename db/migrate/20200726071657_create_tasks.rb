class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :type
      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.string :location
      
      t.references :driver, index: true

      t.timestamps
    end
  end
end
