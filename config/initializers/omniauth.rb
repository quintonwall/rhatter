require 'forcedotcom'
#
# Set the default hostname for omniauth to send callbacks to.
# seems to be a bug in omniauth that it drops the httpS
# this still exists in 0.2.0
OmniAuth.config.full_host = 'https://localhost:3000'
#OmniAuth.config.full_host = 'https://rhatter.heroku.com'

module OmniAuth
  module Strategies
    #tell omniauth to load our strategy
    autoload :Forcedotcom, 'lib/forcedotcom'
  end
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :forcedotcom, '3MVG9CVKiXR7Ri5oh_84IylskqO10nW9n6rcGnbQeJ7Z0K91Uzz9TOwukCMYeGlvUsCWlr4ltIjM52iaPf8ON', '8195020619553807815'
  
end
