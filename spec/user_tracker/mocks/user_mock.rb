class User
  include Singleton

  def id
    1
  end

  def name
    "User"
  end

  def email
    "user@gmail.com"
  end
end