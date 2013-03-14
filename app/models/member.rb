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
#  vars       :string(255)
#

class Member < ActiveRecord::Base
  attr_accessible :can_create, :is_admin, :project_id, :user_id, :vars
  belongs_to :project
  belongs_to :user
  validates_format_of :vars, :with => /^[a-zA-Z0-9-_?*,:]*$/

end
