require 'rails_helper'

RSpec.describe XmlParser, type: :controller do

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
			:email_address => "hans.fakeson@fake.de",
			:sap_invoice_number => "010000001282001",
			:fixed_value => "01",
			:amount => "269.88",
			:date_of_export_to_debt_collection => "2017-12-19"
    }
  }

  let(:debtor) { Debtor.create! valid_attributes }

  describe "it " do
    it "returns a success response" do
    	binding.pry
    	klass = Class.new
    	klass.include(XmlParser)
    	klass! 'test-data.xml'
    	Debtor.import! 'test-data.xml'
      expect(Debtor.count).to eq 3
    end
  end

# this is not a test for the the xmlparser.
# add a test where the test dose not parse correctly.


end