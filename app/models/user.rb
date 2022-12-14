# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_many :tasks

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, length: { minimum: 3 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  before_save :downcase_email
  has_secure_password

  private

  def downcase_email
    self.email = email.downcase
  end
end
