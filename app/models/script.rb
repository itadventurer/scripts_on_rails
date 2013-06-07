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
  attr_accessible :name, :project_id, :description, :code, :params
  belongs_to :project
  default_scope order('name COLLATE NOCASE ASC')

  validates :name, 
    presence: true, 
    # Länge zwischen 5 und 50 Zeichen
    length: { minimum: 5, maximum:50 },
    # Name einzigartig
    uniqueness: { case_sensitive: false }
  validates :description,
    presence: true


  # After Save
  before_save :save_file
  after_create :create_dirs

  def create_dirs
  end
  def compile(txt)
    out=[]

    txt.lines.each do |line|
      nline=line
      inc=nline.scan(/^#!include (.*)/i)
      if(inc.length!=0)
        inc=inc[0][0].strip
        include_script=self.project.scripts.find_by_name(inc)
        out.append("# Compiled from: #{inc}")
        line=compile(include_script.code) if include_script!=nil
        out.append line
        out.append("# /end #{inc}")
      else
        pname=self.project.id
        line=line.to_s.sub(/##public_data_path##/i,"public/data/#{pname}/")
        line=line.to_s.sub(/##private_data_path##/i,"data/scriptdata/#{pname}/")
        line=line.to_s.sub(/##script_name##/i,self.name);
        line=line.to_s.sub(/##project_name##/i,self.project.name);
        line=line.to_s.sub(/##public_data_url##/i,$request.protocol + $request.env['HTTP_HOST'] + "/public/data/#{pname}/")
        out.append line
      end


    end
    out
  end

  def save_file
    print self.params.lines
    self.params=self.params.lines.map(&:strip) * ','
    if(self.path=='' || self.path==nil)
      o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      self.path =  (0...5).map{ o[rand(o.length)] }.join
    end
    txt=self.code
    path="#{Rails.root}/data/#{self.path}"
    File.open("#{path}", 'w') do |f| 
      ### This code should not be in this file
      txt=compile(txt)
      ### /END
      f.puts("#!" + self.project.language.bin)
      f.puts("#coding=utf-8")
      f.puts("#" + I18n.t('misc.gen_str'))
      f.puts(txt)
      f.chmod(0700)
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
end
