class QuizGroup < ApplicationRecord
  has_many :quizzes
  validates :name, presence: true, uniqueness: true

  enum status: {
    inactive: 0,
    active: 1
  }

  before_create do
    self.status ||= :active
  end
end
