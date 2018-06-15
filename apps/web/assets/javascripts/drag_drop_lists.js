var lists = document.getElementsByName('list');

for (var i = 0; i < lists.length; i++) {
	var sort = Sortable.create(lists[i], {
		onUpdate: function (evt/**Event*/){
			var item = evt.item;
			console.log("onUpdate");
		}
	});
}
