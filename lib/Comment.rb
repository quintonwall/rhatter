class Comment
  
  attr_accessor :feeditemid, :body
  
  def initialize(fid, btext)
    @feeditemid = fid
    @body = btext
  end
  
end