# == Schema Information
#
# Table name: list_subscribers
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  subscribed :boolean          default(TRUE)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# 
# require 'rails_helper'
#
# RSpec.describe ListSubscriber, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
