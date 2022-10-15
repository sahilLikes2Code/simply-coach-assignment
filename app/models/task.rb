# frozen_string_literal: true

class Task < ApplicationRecord
  enum status: { due: 0, completed: 1 }

  belongs_to :user

  validates :name, presence: true, length: { minimum: 10 }
  validates :due_date, presence: true

  before_save :downcase_name

  private

  def downcase_name
    self.name = name.downcase
  end
end
