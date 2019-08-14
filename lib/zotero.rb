require 'active_support/core_ext/hash/keys'

module Zotero
  module Entities; end
  module Styles; end
end

puts "hey!"
Gem.find_files('zotero/**/*.rb').each { |path| puts path; require path }
