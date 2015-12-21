class ListSubscribersController < ApplicationController
  before_filter :load_list_subscriber

  def edit
  end

  def update
    @list_subscriber ||= ListSubscriber.new(email: params[:email])
    @list_subscriber.email = params[:email]
    @list_subscriber.subscribed = (params[:subscribed] == "true")
    if @list_subscriber.save
      set_subscriber(@list_subscriber)

      if params[:redirect]
        flash[:notice] = "Subscription settings saved."
        redirect_to params[:redirect]
      else
        redirect_to "/subscribe/success"
      end
    else
      render :edit
    end
  end

  def success
    if current_subscriber.blank?
      redirect_to "/subscribe"
    end
  end

  def confirm
    # TODO: confirm subscription
  end

  protected
  def load_list_subscriber
    @list_subscriber = current_subscriber
  end


end
