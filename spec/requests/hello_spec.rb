# require "rails_helper"
#
# RSpec.describe "Hello", :type => :request do
#   context "When asking hello" do
#     before do
#       headers = {
#         "ACCEPT" => "application/json",     # This is what Rails 4 accepts
#       }
#
#       # post with params
#       get("/hello", {}, headers)
#     end
#
#     it "should return with proper http" do
#       expect(response.content_type).to eq("application/json")
#       expect(response).to have_http_status(200)
#     end
#
#     it "should save that article to the database" do
#       expect(response.body).to include("Hello #{ENV['USER']}")
#     end
#   end
# end
