class Zotero::Entities::Collection 
  attr_reader :name

  def initialize(api, data)
    @api = api

    @key = data['key']
    @no_entries = 0 == data['meta']['numItems']
    @no_collections = 0 == data['meta']['numCollections']
    @name = data['data']['name']
  end

  def collections
    @collections ||= get_collections
  end

  def entries
    @entries ||= get_entries
  end

  def to_h
    {
      name: name, 
      collections: collections.collect(&:to_h),
      entries: entries.collect(&:to_h)
    }.symbolize_keys
  end

  # Eager-load all entries and child collections
  def preload
    entries
    collections.each &:preload
    nil
  end

  private 

  def get_collections
    return [] if @no_collections

    @api.get("collections/#{@key}/collections").collect do |data|
      ::Zotero::Entities::Collection.new @api, data
    end
  end

  def get_entries
    return [] if @no_entries

    @api.get("collections/#{@key}/items").select{ |data|
      'attachment' != data['data']['itemType']
    }.collect do |data|
      ::Zotero::Entities::Entry.new data
    end
  end
end
