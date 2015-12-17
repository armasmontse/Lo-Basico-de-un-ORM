require 'sqlite3'

APP_ROOT = File.expand_path(__dir__)

# This converts a Hash with Strings as keys to a Hash with symbols as keys
# If a key doesn't response to to_sym, do nothing
class Hash
  def symbolize_keys
    dup.symbolize_keys!
  end

  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
end

require_relative File.join('models', 'mini_active_record_model')
require_relative File.join('models', 'chef')
require_relative File.join('models', 'meal')

MiniActiveRecord::Model.database = File.join(APP_ROOT, 'db', 'chefs.db')
