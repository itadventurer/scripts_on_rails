module UsersHelper
  def getName(user)
    if user.name==nil && user.surname==nil
      name=user.email
    elsif user.name==nil
      name=user.surname
    elsif user.surname==nil
      name=user.name
    else
      name=user.name + ' ' + user.surname
    end
    return name
  end
end
