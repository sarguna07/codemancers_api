class Quiz < ApplicationRecord
  validates :question, :answer, presence: true
  validates :option_one, :option_two, :option_three, :option_four, presence: true

  enum status: {
    inactive: 0,
    active: 1
  }

  before_create do
    self.status ||= :active
  end

  def index_json
    as_json(except: %i[answer created_at updated_at status])
  end

  def self.search_records(params)
    params[:order] ||= 'created_at'
    limit, offset, _query, order = parse_params(params)
    quiz = Quiz.reorder(order)
    [
      quiz.offset(offset).limit(limit).map(&:index_json),
      quiz.count
    ]
  end
end
