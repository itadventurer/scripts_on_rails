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
#  path        :string(255)
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


  # After Save
  before_save :save_file

  def save_file
    if(self.path=='' || self.path==nil)
      o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      self.path =  (0...5).map{ o[rand(o.length)] }.join
    end
    txt=self.code
    path="#{Rails.root}/data/#{self.path}"
    File.open("#{path}", 'w') do |f| 
      f.puts("#!" + self.project.language.bin)
      f.puts("#" + I18n.t('misc.gen_str'))
      f.puts(txt)
      f.chmod(0700)
    end
  end
end
