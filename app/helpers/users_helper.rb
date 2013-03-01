module UsersHelper
  def getName(user)
    if user.name=='' && user.surname==''
      name=user.email
    elsif user.name==''
      name=user.surname
    elsif user.surname==''
      name=user.name
    else
      name=user.name + ' ' + user.surname
    end
    return name
  end
end
