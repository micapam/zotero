class Zotero::Entities::Collection 
  attr_reader :name

  def initialize(api, data)
    @api = api

    @key = data['key']
    @no_items = 0 == data['meta']['numItems']
    @no_collections = 0 == data['meta']['numCollections']
    @name = data['data']['name']
  end

  def collections
    @collections ||= get_collections
  end

  def items
    @items ||= get_items
  end

  def to_h
    {
      name: name, 
      collections: collections.collect(&:to_h),
      items: items.collect(&:to_h)
    }.symbolize_keys
  end

  # Eager-load all items and child collections
  def preload
    items
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

  def get_items
    return [] if @no_items

    @api.get("collections/#{@key}/items").select{ |data|
      'attachment' != data['itemType']
    }.collect do |data|
      ::Zotero::Entities::Item.new data
    end
  end
end
