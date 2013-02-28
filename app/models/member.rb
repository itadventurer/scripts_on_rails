# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  project_id :integer
#  user_id    :integer
#  is_admin   :boolean
#  can_create :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Member < ActiveRecord::Base
  attr_accessible :can_create, :is_admin, :project_id, :user_id
  belongs_to :project
  belongs_to :user

end
