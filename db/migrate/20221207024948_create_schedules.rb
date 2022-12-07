class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.time :start
      t.time :finish
      t.integer :day
      t.references :branch, null: false, foreign_key: true
      t.timestamps
    end
  end
end
