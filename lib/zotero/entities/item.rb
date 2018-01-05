require 'active_support/core_ext/string/inflections'

#TODO: rationalise these, find list of Zotero item types & attributes
ITEM_ATTS = %w(
  blog_title
  date
  edition
  issue
  number_of_volumes
  pages
  place
  publication_title
  publisher
  series
  series_number
  title
  url
  volume
)

class Zotero::Entities::Item 
  attr_reader :creators, :kind, *ITEM_ATTS

  def initialize(data)
    @key = data['key']  
    @kind = data['data']['itemType'] 
    @creators = generate_creators data['data']['creators']

    ITEM_ATTS.each do |att|
      instance_variable_set "@#{att}", data['data'][att.camelize(:lower)]
    end
  end

  def creator_sort_string
    creators.collect {|creator|
      "#{creator.last_name} #{creator.first_name}"
    }.join(' ')
  end

  def to_h
    ((ITEM_ATTS + [:kind]).collect {|att|
      [att, send(att)]
    } + [:creators, creators.collect(&:to_h)]).to_h
  end

  private

  def generate_creators(data)
    return [] unless data

    data.collect do |creator_data| 
      ::Zotero::Entities::Creator.new creator_data
    end
  end
end
