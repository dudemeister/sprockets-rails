require "sprockets"
require "sprockets_helper"
require "sprockets_application"

class ActionController::Base
  helper :sprockets
end

module SprocketsRails
  class Engine < Rails::Engine
  end
end
