class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  
  
  protected
  
  def authorize
    unless ENV['sfdc_token']
      redirect_to :controller => 'sessions', :action => 'authenticate'
    end
  end
end
