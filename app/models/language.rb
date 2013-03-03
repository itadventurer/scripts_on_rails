# == Schema Information
#
# Table name: languages
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  editor_config :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Language < ActiveRecord::Base
  attr_accessible :editor_config, :name, :bin
end
