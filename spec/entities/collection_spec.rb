require 'spec_helper'

describe Zotero::Entities::Collection do 
  let(:top_data) { JSON.parse(File.read('./spec/support/top_collections.json')) }
  let(:sub_data) { JSON.parse(File.read('./spec/support/sub_collections.json')) }
  let(:entries_data) { JSON.parse(File.read('./spec/support/entries.json')) }
  let(:api) { double 'api' }
  subject { described_class.new api, collection_data }

  context 'parent, no entries' do
    let(:collection_data) { top_data.last }

    specify { expect(subject.name).to eq 'Digitality' }

    it 'should not bother loading entries as there are none' do 
      expect(api).not_to receive(:get)
      entries = subject.entries
      expect(entries).to be_empty
    end

    it 'should load child collections' do 
      expect(api).to receive(:get).with(
        "collections/#{top_data.last['key']}/collections"
      ).and_return(sub_data)

      collections = subject.collections

      expect(collections.size).to eq 2
    end
  end

  context 'child, has entries, no children' do
    let(:collection_data) { sub_data.last }

    specify { expect(subject.name).to eq 'Interface' }

    it 'should not bother loading child collections as there are none' do 
      expect(api).not_to receive(:get)
      collections = subject.collections
      expect(collections).to be_empty
    end

    it 'should load entries' do 
      expect(api).to receive(:get).with(
        "collections/#{sub_data.last['key']}/items"
      ).and_return(entries_data)

      entries = subject.entries

      expect(entries.size).to eq 25
    end

    describe '#to_h' do 
      let(:hash) do
        allow(api).to receive(:get).and_return(entries_data)
        subject.to_h 
      end

      specify { expect(hash[:name]).to eq subject.name }
      specify { expect(hash[:collections]).to eq [] }
      specify { expect(hash[:entries].size).to eq 25 }
    end
  end
end
