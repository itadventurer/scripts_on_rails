# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  language_id :integer
#

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
