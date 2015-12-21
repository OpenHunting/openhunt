class ListSubscribersController < ApplicationController
  before_filter :load_list_subscriber

  def edit
  end

  def update
    @list_subscriber ||= ListSubscriber.new(email: params[:email])
    @list_subscriber.email = params[:email]
    if @list_subscriber.save
      set_subscriber(@list_subscriber)
      redirect_to "/subscribe/success"
    else
      render :edit
    end
  end

  def success
    if current_subscriber.blank?
      redirect_to "/subscribe"
    end
  end

  def destroy
    # TODO: unsubscribe
  end

  def confirm
    # TODO: confirm subscription
  end

  protected
  def load_list_subscriber
    @list_subscriber = current_subscriber
  end


end
