class PagesController < ApplicationController
  def hello
    @username = ENV['USER']
    respond_to do |format|
      format.html
      format.json do
        render json: {
          msg: "Hello #{@username}"
        }
      end
    end
  end
end
