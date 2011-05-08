require 'Chatter'
require 'Post'
require 'Comment'

class ChatterPostsController < ApplicationController
  
  
  def newcomment
  
  end
  
  def addcomment
    @comment = Comment.new(params[:feeditemid], params[:body])
    Chatter.add_comment(@comment)
    
    redirect_to my_chatter_mynewsfeed_path
  end
  

  #called when we create a new status request
  def newstatus
    @post = Post.new
    @post.body = params[:body]
    Chatter.set_my_user_status(@post)
    
    redirect_to my_chatter_home_path
  end
  
  def like
    puts "--->"
    puts params[:feeditemid]
    Chatter.like_feeditem(params[:feeditemid])
    redirect_to my_chatter_mynewsfeed_path
  end

end
