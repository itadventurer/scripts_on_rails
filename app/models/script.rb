# == Schema Information
#
# Table name: scripts
#
#  id         :integer          not null, primary key
#  project_id :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Script < ActiveRecord::Base
  attr_accessible :name, :project_id
end
