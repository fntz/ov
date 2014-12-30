require "ov"



include Ov::Ext



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










