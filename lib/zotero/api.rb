require 'rest-client'
require 'json'

class Zotero::Api
  def initialize(user_id, key)
    @user_id = user_id
    @key = key
  end

  def get(path_fragment)
    body = nil 
    the_next = "https://api.zotero.org/users/#{@user_id}/#{path_fragment}"
    loop do
      response = RestClient.get(the_next, {
        'Zotero-API-Version' => 3,
        'Zotero-API-Key' => @key
      })  
      if body.nil?
        body = ::JSON.parse(response.body)
      else
        body += ::JSON.parse(response.body)
      end 

      links = response.headers[:link].split(', ')
      the_next = '' # reset it
      links.each do |link|
        if link.end_with?('; rel="next"')
          the_next = link.match(/<(.+)>/)[1]
        end 
      end 
      break if the_next.empty?
    end 
    return body
  end
end
