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

require 'test_helper'

class ScriptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
