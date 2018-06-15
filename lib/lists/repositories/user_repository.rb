class UserRepository < Hanami::Repository
  associations do
    has_many :lists
  end

  def find_by_email(email)
    users.where(email: email).as(User).one
  end

  def find_lists(user_id)
    assoc(:lists, user_id)
			.order(:position)
  end

  def find_by_token(token)
    users.where(token: token).as(User).one
  end
end
