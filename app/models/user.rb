# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  surname                :string(255)
#  is_admin               :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  vars                   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :vars
  attr_accessible :is_admin, :name, :surname
  default_scope order('email COLLATE NOCASE ASC')
  
  
  has_many  :members
  has_many :projects, through: :members

  def can_create(project)
    return false unless project.in?(self.projects)
    member=self.members.find_by_project_id(project.id)
    return member.can_create
  end
  def is_admin_of(project)
    return false unless project.in?(self.projects)
    member=self.members.find_by_project_id(project.id)
    return member.is_admin
  end
end
