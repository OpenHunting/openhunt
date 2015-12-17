# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :uuid(16)         not null
#  project_id :uuid(16)         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :project, counter_cache: true

end
