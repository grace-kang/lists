var lists = document.getElementsByName('list');
console.log(lists);

for (var i = 0; i < lists.length; i++) {
	var sort = Sortable.create(lists[i], {
		onUpdate: function (evt/**Event*/){
			var item = evt.item;
		}
	});
}
