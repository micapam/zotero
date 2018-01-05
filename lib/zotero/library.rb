class Zotero::Library 
  attr_reader :collections

  def initialize(user_id, key)
    @api = ::Zotero::Api.new(user_id, key)
  end

  def collections
    @collections ||= get_collections
  end

  private 

  def get_collections
    @api.get('/collections/top').collect do |data|
      ::Zotero::Entities::Collection.new @api, data
    end
  end
end
