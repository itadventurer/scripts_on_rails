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

class Project < ActiveRecord::Base
  attr_accessible :description, :language, :name, :language_id

  has_many :scripts
  has_many :members
  has_many :users, through: :members
  belongs_to :language
  default_scope order('name COLLATE NOCASE ASC')
  
	validates :name, 
		presence: true, 
		# Name einzigartig
		uniqueness: { case_sensitive: false }

  validates :description,
    presence: true

  validates :language,
    presence:true 

  before_destroy :recursive_destroy

  def recursive_destroy
    self.scripts.each { |s| s.destroy }
    self.members.each { |m| m.destroy }
  end

end
