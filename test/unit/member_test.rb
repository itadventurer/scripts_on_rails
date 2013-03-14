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

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
