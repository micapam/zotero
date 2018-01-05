require 'rest-client'
require 'json'

class Zotero::Api
  def initialize(user_id, key)
    @user_id = user_id
    @key = key
  end

  def get(path_fragment)
    ::JSON.parse(RestClient.get("https://api.zotero.org/users/#{@user_id}/#{path_fragment}", {
      'Zotero-API-Version' => 3,
      'Zotero-API-Key' => @key
    }).body)
  end
end
