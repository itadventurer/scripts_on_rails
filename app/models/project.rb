# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  language    :string(255)
#  description :string(255)
#  cli         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :cli, :description, :language, :name, :language_id

  has_many :scripts
  has_many :members
  has_many :users, through: :members
  belongs_to :language
  
	validates :name, 
		presence: true, 
		# Länge zwischen 5 und 50 Zeichen
		length: { minimum: 5, maximum:50 },
		# Name einzigartig
		uniqueness: { case_sensitive: false }

  validates :description,
    presence: true

  validates :language,
    presence:true 

end
