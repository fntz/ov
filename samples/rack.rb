require "ov"
require "rack"

#curl -X POST http://localhost:9292
#curl -X GET http://localhost:9292

class Post ; end 
class Get  ; end

class Rack::Request
  def req_method
    return Post.new if post?
    Get.new 
  end   
end

class RackExample
  include Ov
  def call(env)
    response(Rack::Request.new(env).req_method)
    #[200, {"Content-Type" => "text/html"}, ["POST"]]
  end

  let :response, Get do |r|
    # processing get
    [200, {"Content-Type" => "text/html"}, ["GET"]]
  end

  let :response, Post do |r|
    # processing post
    [200, {"Content-Type" => "text/html"}, ["POST"]]
  end 

end

if __FILE__ == $0
  Rack::Handler::Thin.run RackExample.new, :Port => 9292  
end









