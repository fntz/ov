require "ov"

module Matching
  def match(*args, &block)
    z = Module.new do 
      include Ov
      extend self
      def try(*args, &block)
        let :anon_method, *args, &block
      end
      def otherwise(&block)
        let :otherwise, &block
      end
      instance_eval &block
    end
    begin
      z.anon_method(*args)
    rescue NotImplementError => e 
      z.otherwise
    end  
  end
end


include Matching



match("String", [123]) do 
  try(String, Array) {|str, arr| p "#{str} #{arr}" }
  try(String) {|str| p "#{str}"  }
  otherwise { p "none" }
end

require "net/http"

match(Net::HTTP.get_response(URI("http://google.com"))) do
  try(Net::HTTPOK) {|r| p r.header }
  try(Net::HTTPMovedPermanently) {|r| p r.header }
  otherwise { p "error" }
end










