# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OmniauthDemo::Application.initialize!

# store the json output of chatter requess
CHATTER_LOGGER = Logger.new("#{RAILS_ROOT}/log/chatter.log")
CHATTER_LOGGER.level = Logger::DEBUG

# Set our instance URL for Force.com
#ENV['sfdc_instance_url'] = 'https://na6.salesforce.com'
#Must be 22 or greater for Chatter REST API
ENV['sfdc_api_version'] = '22.0'
