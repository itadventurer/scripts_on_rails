class Project < ActiveRecord::Base
  attr_accessible :cli, :description, :language, :name
end
