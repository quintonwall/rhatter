require 'Accounts'

class SessionsController < ApplicationController
  skip_before_filter :authorize
  
  def create
    ENV['sfdc_token'] = request.env['omniauth.auth']['credentials']['token']
    ENV['sfdc_instance_url'] = request.env['omniauth.auth']['instance_url']
    
    redirect_to '/my_chatter/home'
    #render :text => request.env['omniauth.auth'].inspect
    #render :text => Accounts.get_first_hundred.inspect
  end

  def fail
    render :text =>  request.env["omniauth.auth"].to_yaml
  end

  def authenticate
    redirect_to '/auth/forcedotcom'
  end
  
  #TODO
  #def list
  #  render :text => Accounts.get_first_hundred.inspect
  #end

end
