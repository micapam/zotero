require 'active_support/core_ext/hash/keys'

module Zotero
  module Entities; end
  module Styles; end
end

Gem.find_files('Zotero/**/*.rb').each { |path| require path }
