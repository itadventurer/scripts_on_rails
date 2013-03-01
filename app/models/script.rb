# == Schema Information
#
# Table name: scripts
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  code        :text
#

class Script < ActiveRecord::Base
  attr_accessible :name, :project_id, :description, :code
  belongs_to :project

	validates :name, 
		presence: true, 
		# Länge zwischen 5 und 50 Zeichen
		length: { minimum: 5, maximum:50 },
		# Name einzigartig
		uniqueness: { case_sensitive: false }
  validates :description,
    presence: true
  validates :code,
    presence: true
end
