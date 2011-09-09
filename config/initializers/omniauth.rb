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
  provider :forcedotcom, '3MVG99OxTyEMCQ3jIW9bdxrL5aCaG9w7u2AC0RqGejjqf50NfYA_iwP5H84fKT9oCD9.DXzagehMBaCGU7cSA', '9153528620843249482'
  
end
