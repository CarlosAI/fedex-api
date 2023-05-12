require 'spec_helper'
require_relative '../lib/fedex'

describe Fedex::Rates do
  let(:credentials) { {"fedex_key"=> "AAAAA", "fedex_password"=> "AAAAA", "fedex_account_number"=> "1000", "fedex_meter_number"=> "100"} }
  let(:rate_params) { {"address_from" => {"street_name"=> "", "city"=> "", "state_or_province_code"=> "", "zip"=> "64000", "country"=> "MX"}, "address_to"=> {"street_name"=> "", "city"=> "", "state_or_province_code"=> "", "zip"=> "20199", "country"=> "MX"}, "parcel"=> {"mass_unit"=> "KG", "weight"=> "1", "length"=> "25", "width"=> "28", "height"=> "46", "distance_unit"=> "CM"} } }

  describe '.get' do
    it 'returns parsed response body for successful request' do
      allow(Net::HTTP).to receive(:start).and_return(double(code: '200', body: '<Response><Rate>100</Rate></Response>'))
      response = described_class.get(credentials, rate_params)
      expect(response[:code]).to eq('200')
      expect(response[:body]).to eq({"Response"=>{"Rate"=>"100"}})
    end

    it 'raises UnexpectedResponseError for unsuccessful request' do
      allow(Net::HTTP).to receive(:start).and_return(double(code: '500', body: '<Response><Error>Error Message</Error></Response>'))
      expect { described_class.get(credentials, rate_params) }.to raise_error(Fedex::UnexpectedResponseError)
    end
  end
end
