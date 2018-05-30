module Web::Controllers::Home
  class Index
    include Web::Action

    expose :user
    expose :lists

    def call(_)
      check_for_logged_in_user
      handle_session
      user_repo = UserRepository.new
      @user = session[:current_user]

      list_repo = ListRepository.new
      @user = user_repo.find_lists(@user.id)
      @lists = @user.lists
      @lists.map! { |list| list_repo.find_items(list.id) }
    end
  end
end
