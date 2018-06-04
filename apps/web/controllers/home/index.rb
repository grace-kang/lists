module Web::Controllers::Home
  class Index
    include Web::Action
    include Import['repositories.user']
    include Import['repositories.list']
    include Import['repositories.item']

    expose :this_user
    expose :lists

    def call(_)
      check_for_logged_in_user
      handle_session
      @this_user = session[:current_user]

      @this_user = user.find_lists(@this_user.id)
      @lists = @this_user.lists
      @lists.map! { |l| list.find_items(l.id) }
      @lists.each { |l| l.items.map! { |i| item.find_subitems(i.id) } }
    end
  end
end
