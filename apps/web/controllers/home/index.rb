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

			@items = Array.new
			@lists.each do |l|
				@items[l.id] = Array.new
				item_arr = item.find_by_list(l.id)
				item_arr.each do |i|
					@items[l.id].push(i)
				end
			end

			@subitems = Array.new
			@lists.each do |l|
				@items[l.id].each do |i|
					@subitems[i.id] = Array.new
					subitem_arr = subitem.find_with_item(i.id)
					subitem_arr.each do |s|
						@subitems[i.id].push(s)
					end
				end
			end
    end
  end
end
