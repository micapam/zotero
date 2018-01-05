require 'spec_helper'
require 'rest-client'

describe Zotero::Library do 
  let(:user_id) { 'USER_ID' }
  let(:api_key) { 'API_KEY' }

  subject { described_class.new(user_id, api_key) }

  it 'should request collections' do 
    expect(
      subject.instance_variable_get('@api')
    ).to receive(:get).with('/collections/top').and_return(
      JSON.parse(File.read('./spec/support/top_collections.json'))
    )

    # There are three top-level collections in the example
    expect(Zotero::Entities::Collection).to receive(:new).exactly(3).times

    subject.collections
  end
end
