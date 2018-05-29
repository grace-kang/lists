class UserRepository < Hanami::Repository
  associations do
    has_many :lists
  end

  def find_by_email(email)
    users.where(email: email).as(User).one
  end

  def find_lists(id)
    aggregate(:lists).where(id: id).as(User).one
  end
end
