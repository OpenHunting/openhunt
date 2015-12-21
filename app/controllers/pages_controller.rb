class PagesController < ApplicationController
  def about

  end

  def people
  end

  def faq
  end

  def differences
  end

  def governance
  end

  if Rails.env.development?
    def test_flash
      type = (params[:type] || "alert").to_sym
      msg = params[:message].presence || "Some test flash"
      flash[type] = msg
      redirect_to "/"
    end

    def devauth
      if params[:screen_name].present?
        user = User.where(screen_name: params[:screen_name]).first
        if user.present?
          session[:user_id] = user.id
          redirect_to "/"
          return
        end
      end

      # TODO: paginate
      @users = User.all.order(:created_at => :asc).limit(200)
    end
  end
end
