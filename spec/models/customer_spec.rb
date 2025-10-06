require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject do
    described_class.new(
      first_name: "Aldrien",
      last_name: "Hate",
      phone_number: "1234567890",
      date_of_birth: 34.years.ago
    )
  end

  describe "validations" do
    it "is valid with correct attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a first_name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:first_name]).to include("can't be blank")
    end

    it "is not valid without a last_name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:last_name]).to include("can't be blank")
    end

    it "is not valid without a phone_number" do
      subject.phone_number = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:phone_number]).to include("can't be blank")
    end

    it "is not valid without a date_of_birth" do
      subject.date_of_birth = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:date_of_birth]).to include("can't be blank")
    end

    it "is not valid if date_of_birth is in the future" do
      subject.date_of_birth = Date.tomorrow
      expect(subject).to_not be_valid
      expect(subject.errors[:date_of_birth]).to include("can't be in the future")
    end

    it "is not valid if first_name + last_name combination is not unique" do
      described_class.create!(
        first_name: "Aldrien",
        last_name: "Hate",
        phone_number: "1111111111",
        date_of_birth: 20.years.ago
      )
      expect(subject).to_not be_valid
      expect(subject.errors[:first_name]).to include("and last name combination must be unique")
    end
  end
end
