require 'spec_helper'

describe Zotero::Entities::Item do
  let(:items_data) { JSON.parse(File.read('./spec/support/items.json')) }  
  subject { described_class.new item_data }

  context 'book' do 
    let(:item_data) { items_data[3] }
    let(:author) { subject.creators.first }

    specify { expect(subject.title).to eq 'Faceless Book' }
    specify { expect(subject.kind).to eq 'blogPost' }
    specify { expect(subject.blog_title).to eq 'Supervalent Thought' }
    specify { expect(subject.date).to eq 'December 2007' }
    specify { expect(subject.creators.size).to eq 1 }
    specify { expect(author.last_name).to eq 'Berlant' }
    specify { expect(author.first_name).to eq 'Lauren' }
    specify { expect(author.kind).to eq 'author' }

    describe '#to_h' do
      let(:hash) { subject.to_h }

      specify { expect(hash[:title]).to eq subject.title }
    end
  end
end
