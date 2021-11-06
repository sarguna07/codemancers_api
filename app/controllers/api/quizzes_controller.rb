module Api
  class QuizzesController < ApplicationController
    skip_before_action :authorization, only: %i[submit index]

    def create
      raise InvalidParams, 'Answer doesn\'t match' unless options.values.include?(params[:answer])

      data = Quiz.create!(create_params)
      render json: {
        status: true,
        message: 'Saved Successfully...!',
        data: data.id
      }
    end

    def index
      data, total_entries = Quiz.search_records(params)
      render json: {
        status: true,
        data: data,
        total_entries: total_entries
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

    private

    def create_params
      params.permit(:question, :option_one, :option_two, :option_three, :option_four, :answer)
    end

    def options
      params.permit(:option_one, :option_two, :option_three, :option_four)
    end
  end
end
