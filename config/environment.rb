# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

console do
  config.eager_load = true
end
