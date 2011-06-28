require 'Chatter'

class MyChatterController < ApplicationController
  
  def home
    @userInfo = Chatter.get_my_info
    puts "-------------"
    puts @userInfo
 puts "-------------"
   end
  
  def newstatus
  
  end
  
  def myfollowers
  
  end
  
  def imfollowing
  
  end
  
  def mygroups
  
  end
  
  def mynewsfeed
    if (!params[:nextpageurl].nil?)
        @feed = Chatter.get_page_of_feed(params[:nextpageurl])
      elsif (!params[:previouspageurl].nil?)
         @feed = Chatter.get_page_of_feed(params[:previouspageurl])
    else
        @feed = Chatter.get_my_newsfeed
    end
        #puts "NEXT"
        #puts @feed["feedItems"]["nextPageUrl"]
        
        #puts "PREV"
        #puts @feed["feedItems"]["previousPageUrl"]
        
         puts "-------------"
         puts @feed
         puts "-------------"
   
  end
  

  
  def newchatterpic
    #todo: rest api supports uploading of a new chatter pic.
    # need to use phonegap to make this work but phonegap only works on
    # client side technology, not serverside like rails
    # http://docs.phonegap.com/phonegap_camera_camera.md.html
  end
  
  
  

end
