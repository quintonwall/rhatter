require 'rubygems'
require 'httparty'
require 'Post'

class Chatter
  include HTTParty
  #doesn't seem to pick up env variable correctly if I set it here
  #headers 'Authorization' => "OAuth #{ENV['sfdc_token']}"
  format :json
  #debug_output $stderr

  def self.set_headers
    headers 'Authorization' => "OAuth #{ENV['sfdc_token']}"
  end

  def self.root_url
    @root_url = ENV['sfdc_instance_url']+"/services/data/v"+ENV['sfdc_api_version']+"/chatter"
  end

  def self.get_users_info(id)
    Chatter.set_headers
    get(Chatter.root_url+"/users/"+id)
  end

  def self.get_my_info
    Chatter.get_users_info("me")
  end
  
  def self.get_newsfeed(id)
    Chatter.set_headers
    get(Chatter.root_url+"/feeds/news/"+id)
  end
    
  def self.get_my_newsfeed
    Chatter.get_newsfeed("me")
  end
  
  def self.set_my_user_status(post)
    post(Chatter.root_url+"/feeds/news/me/feed-items?text="+CGI::escape(post.body))
  end
  
  def self.like_feeditem(id)
    post(Chatter.root_url+"/feed-items/"+id+"/likes")
  end
  
  def self.add_comment(comment)
    post(Chatter.root_url+"/feed-items/"+comment.feeditemid+"/comments?text="+CGI::escape(comment.body))
  end
  
  #pre rel chatter page results returns the incorrect json response. it should be [feeditems][items]
  #like everything else, but it is just [items] so lets wrap it to make it consistent
  def self.get_page_of_feed(refpath)
    Chatter.set_headers
    
     @feed = Hash.new{}
      @feed["feedItems"] = Hash.new{} 
      
       @feed["feedItems"] = get(ENV['sfdc_instance_url']+refpath)
       return @feed
  end
end
