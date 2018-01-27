class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.integer :duration_in_min
      t.text :workout
      t.string :workout_date
      t.string :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
