class Member < ActiveRecord::Base
  attr_accessible :can_create, :is_admin, :project_id, :user_id
end
