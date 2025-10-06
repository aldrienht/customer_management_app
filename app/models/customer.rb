class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name, message: "and last name combination must be unique" }
  validates :phone_number, presence: true
  validates :date_of_birth, presence: true
  validate  :date_of_birth_cannot_be_in_the_future

  private

  def date_of_birth_cannot_be_in_the_future
    return if date_of_birth.blank?
    if date_of_birth > Date.today
      errors.add(:date_of_birth, "can't be in the future")
    end
  end
end
