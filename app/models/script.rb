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
#  params      :string(255)
#

class Script < ActiveRecord::Base
  attr_accessible :name, :project_id, :description, :code, :params, :filename
  belongs_to :project
  default_scope order('name COLLATE NOCASE ASC')

  validates :name, 
    presence: true, 
    # Länge zwischen 5 und 50 Zeichen
    # Name einzigartig
    uniqueness: { case_sensitive: false }
  validates :description,
    presence: true


  # After Save
  before_save :fixFile

  def fixFile
    pathname=getPath
    if pathname.exist?
        self.filename=File.basename(pathname.realpath)
        `chmod +x #{pathname.realpath}`
    end
  end

  def getParams
    ret={}
    return ret if params.nil?
    self.params.split(',').each do |param|
      parray=param.split ':'
      parray[1]='string' if parray[1].nil?
      ret[parray[0]]=parray[1]
    end
    ret
  end

  def getPath
    Pathname.new ("#{Rails.root}/" + APP_CONFIG['git_path'] + self.project.name + "/" + self.filename)
  end
end
