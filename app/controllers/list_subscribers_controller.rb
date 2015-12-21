class ListSubscribersController < ApplicationController
  before_filter :load_list_subscriber

  def lookup
    # TODO: lookup by email
  end

  def edit
    # TODO: show edit form
  end

  def update
    # TODO: edit email
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
