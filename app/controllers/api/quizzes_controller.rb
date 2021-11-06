module Api
  class QuizzesController < ApplicationController
    skip_before_action :authorization, only: %i[submit questions]

    def create
      ActiveRecord::Base.transaction do
        group = QuizGroup.create!(name: params[:name])

        params[:quiz].map do |que|
          raise InvalidParams, 'Answer doesn\'t match' unless que.values.include?(que[:answer])

          group.quizzes.create!(
            question: que[:question],
            option_one: que[:option_one],
            option_two: que[:option_two],
            option_three: que[:option_three],
            option_four: que[:option_four],
            answer: que[:answer]
          )
        end
      end

      render json: {
        status: true,
        message: 'Saved Successfully...!'
      }
    end

    def submit
      mark = 0
      params[:quiz].map do |ans|
        find_question = Quiz.active.find_by(id: ans['id'], answer: ans['answer'])
        mark += 1 if find_question
      end
      percentage = ((mark.to_f / Quiz.active.count.to_f) * 100)
      render json: {
        status: true,
        message: 'Submitted Succesfully..!',
        data: percentage
      }
    end

    def questions
      group = QuizGroup.find_by(name: params[:name])
      data = Quiz.where(quiz_group_id: group&.id)

      render json: {
        status: true,
        data: data.as_json(except: %i[answer created_at updated_at status quiz_group_id])
      }
    end
  end
end
