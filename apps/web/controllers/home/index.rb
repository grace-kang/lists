module Web::Controllers::Home
  class Index
    include Web::Action
    include Import['repositories.user']
    include Import['repositories.list']
    include Import['repositories.item']
		include Import['repositories.subitem']

    expose :this_user
    expose :lists
		expose :items
		expose :subitems

    def call(_params)
      check_for_logged_in_user
      handle_session
      @this_user = session[:current_user]
      @lists = list.find_with_user_id(@this_user.id)

			@items = {}
			@lists.each do |l|
				@items[:"#{ l.id }"] = []
				item_arr = item.find_by_list(l.id)
				item_arr.each do |i|
					@items[:"#{ l.id }"].push(i)
				end
			end

			@subitems = {}
			@lists.each do |l|
				@items[:"#{ l.id }"].each do |i|
					@subitems[:"#{ i.id }"] = []
					subitem_arr = subitem.find_with_item(i.id)
					subitem_arr.each do |s|
						@subitems[:"#{ i.id }"].push(s)
					end
				end
			end
    end
  end
end
