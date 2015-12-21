
# == Schema Information
#
# Table name: list_subscribers
#
#  id           :integer          not null, primary key
#  email        :string           not null
#  subscribed   :boolean          default(TRUE)
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  confirmed    :boolean          default(FALSE)
#  confirm_code :string
#  weekly       :boolean
#
