require 'rails_helper'

RSpec.describe Debtor, type: :model do

  let(:valid_attributes) {
    {
      :system_id => "INK003    4628681287",
      :customer_number => "4628681287",
      :gender => "0001",
      :first_name => "hans",
      :last_name => "fakeson",
      :iso_code_language => "AT",
      :iso_code_communication_language => "de",
      :iso_code_address_country => "AT",
      :zip => "1111",
      :city => "Wien",
      :street => "test 123",
      :house_number => "test 123",
      :phone_number => "+4364412312312",
      :mobile_phone_number => "+4364412312312",
      :email_address => "hans.fakeson@fake.de"
    }
  }

  let(:invalid_attributes) {
    {
      :system_id => "INK003    4628681287",
      :customer_number => "4628681287",
      :gender => "0009",
      :first_name => "hans",
      :last_name => "fakeson",
      :iso_code_language => "AT",
      :iso_code_communication_language => "de",
      :iso_code_address_country => "AT",
      :zip => "1111",
      :city => "Wien",
      :street => "test 123",
      :house_number => "test 123",
      :phone_number => "+4364412312312",
      :mobile_phone_number => "+4364412312312",
      :email_address => "hans.fakeson@fake.de"
    }
  }

  it "has none to begin with" do
    expect(Debtor.count).to eq 0
  end

  it "has one after adding one" do
    Debtor.create! valid_attributes
    expect(Debtor.count).to eq 1
  end

  it "has none after one was created in a previous example" do
    expect(Debtor.count).to eq 0
  end

  it "fails to translate gender codes" do
    debtor = Debtor.new invalid_attributes
    expect(debtor).to_not be_valid
    expect(debtor.errors.messages[:gender]).
      to eq ["can't be blank", "is not included in the list"]
    expect(Debtor.count).to eq 0
  end

  it "translates gender codes" do
    Debtor.create! valid_attributes
    expect(Debtor.last.gender).to eq 'Frau'
    Debtor.delete_all
    valid_attributes[:gender] = '0002'
    Debtor.create! valid_attributes
    expect(Debtor.last.gender).to eq 'Herr'
    Debtor.delete_all
    valid_attributes[:gender] = '0003'
    Debtor.create! valid_attributes
    expect(Debtor.last.gender).to eq 'Firma'
  end
end
