require 'active_support/core_ext/string/inflections'

#TODO: rationalise these, find list of Zotero item types & attributes
ENTRY_ATTS = %w(
  access_date
  blog_title
  date
  edition
  issue
  number_of_volumes
  pages
  place
  publication_title
  publisher
  running_time
  series
  series_number
  studio
  title
  url
  volume
  website_title
)

class Zotero::Entities::Entry
  attr_reader :creators, :kind, *ENTRY_ATTS

  def initialize(data)
    @key = data['key']  
    @kind = data['data']['itemType'].underscore
    @creators = generate_creators data['data']['creators']

    ENTRY_ATTS.each do |att|
      instance_variable_set "@#{att}", data['data'][att.camelize(:lower)]
    end
  end

  def creator_sort_string 
    @creator_sort_string ||= generate_creator_sort_string
  end

  def to_h
    ((ENTRY_ATTS + [:kind]).collect {|att|
      [att, send(att.to_sym)]
    } + [[:creators, creators.collect(&:to_h)]]).to_h.symbolize_keys
  end

  private

  def generate_creators(data)
    return [] unless data

    data.collect do |creator_data| 
      ::Zotero::Entities::Creator.new creator_data
    end
  end

  def generate_creator_sort_string
    creators.collect {|creator|
      "#{creator.last_name} #{creator.first_name}"
    }.join(' ')
  end
end
