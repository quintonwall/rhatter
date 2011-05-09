require 'forcedotcom'
#
# Set the default hostname for omniauth to send callbacks to.
# seems to be a bug in omniauth that it drops the httpS
# this still exists in 0.2.0
#OmniAuth.config.full_host = 'https://localhost:3000'
OmniAuth.config.full_host = 'https://rhatter.heroku.com'

module OmniAuth
  module Strategies
    #tell omniauth to load our strategy
    autoload :Forcedotcom, 'lib/forcedotcom'
  end
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :forcedotcom, '3MVG9lKcPoNINVBKz3NLecoYVWil54YYnRht9WhG9igtiZy59Wu65PQqgJB3gLF5NQpXZB68UBj3XB5_XWpcP', '8600432689249849627'
end
