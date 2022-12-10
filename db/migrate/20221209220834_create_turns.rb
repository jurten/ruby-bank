class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.references :branch, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.string :reason
      t.integer :status, default: 0
      t.text :comment
      t.references :staff, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
