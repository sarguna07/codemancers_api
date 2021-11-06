class CreateQuiz < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes, id: :uuid do |t|
      t.text :question
      t.string :option_one
      t.string :option_two
      t.string :option_three
      t.string :option_four
      t.string :answer
      t.integer :status
      t.uuid :quiz_group_id
      t.timestamps
    end

    create_table :quiz_groups, id: :uuid do |t|
      t.string :name
      t.integer :status
      t.timestamps
    end
  end
end
