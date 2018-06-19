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

# TODO
# @lists: array of list objects
# @items: nested array of items, each nested array correspoinds to a list via its index
# @subitems: nested array of subitems, each nested corresponds to an item via its index


    def call(_params)
      check_for_logged_in_user
      handle_session
      @this_user = session[:current_user]
#			@this_user = user.find_lists(@this_user.id)
#			@lists = @this_user.lists
      @lists = list.find_with_user_id(@this_user.id)

			@items = Array.new
			@lists.each do |l|
				@items[l.id] = Array.new
				item_arr = item.find_by_list(l.id)
				item_arr.each do |i|
					@items[l.id].push(i)
				end
#				@items[l.id].sort_by { |obj| obj.position }
			end

			@subitems = Array.new
			@lists.each do |l|
				@items[l.id].each do |i|
					@subitems[i.id] = Array.new
					subitem_arr = subitem.find_with_item(i.id)
					subitem_arr.each do |s|
						@subitems[i.id].push(s)
					end
#					@subitems[i.id].sort_by { |obj| obj.position }
				end
			end

#      @lists.map! { |l| list.find_items(l.id) }
#			@lists.map! { |l| l.items.sort_by { |obj| obj.position } }
#      @lists.each { |l| l.items.map! { |i| item.find_subitems(i.id) } }
    end
  end
end
