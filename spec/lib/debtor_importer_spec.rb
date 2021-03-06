require 'rails_helper'

RSpec.describe DebtorImporter do

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

  let(:debtor) { Debtor.create! valid_attributes }

  describe "#import" do

    it "saves new debtors" do
      DebtorImporter.import 'test-data.xml'
      expect(Debtor.count).to eq 3
    end

    it "fails to save" do
      expect { DebtorImporter.import 'test-data-faulty.xml' }.
        to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Gender can't be blank, Gender is not included in the list")
      expect(Debtor.count).to eq 0
    end

    it "removes blankspace from system_id" do
      DebtorImporter.import 'test-data.xml'
      expect(Debtor.first.system_id).to eq 'INK0034628681287'
    end
  end

end
