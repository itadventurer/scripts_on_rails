# == Schema Information
#
# Table name: languages
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  editor_config :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  bin           :string(255)
#

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
