require 'spec_helper'
require 'rest-client'

describe Zotero::Api do 
  let(:user_id) { 'USER_ID' }
  let(:api_key) { 'API_KEY' }

  subject { described_class.new(user_id, api_key) }

  it 'should make a request to the API' do 
    expect(RestClient).to receive(:get).with(
      "https://api.zotero.org/users/#{user_id}/foo",
      'Zotero-API-Version' => 3,
      'Zotero-API-Key' => api_key
    ).and_return(
      double('response', body: { bar: 123 }.to_json)
    )

    subject.get 'foo'
  end
end