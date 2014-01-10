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
  attr_accessible :name, :project_id, :description, :params, :filename
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
    # Git-stuff
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
  def get_code
    return "" if self.new_record?
    filepath=APP_CONFIG['git_path'] + self.project.name + "/" + self.filename
    if File.exists? filepath
        code=File.read filepath
    else
        code="File not found!"
    end
  end 
  def update_code(new_code,commit_message,new=false)
    `git pull`
    filepath=APP_CONFIG['git_path'] + self.project.name + "/" + self.filename
    return if new_code==self.get_code and not new
    new_code=new_code.gsub(/\r\n?/, "\n") # This is not awesome…
    `git add #{filepath}`
    `chmod a+x #{filepath}`
    File.open(filepath, 'w') { |file| file.write(new_code) }
    commit_message="Update #{self.filename}" if commit_message.empty?
    `cd #{APP_CONFIG['git_path']} && git commit -am "#{commit_message}" 2>&1 && git push`
  end
end
