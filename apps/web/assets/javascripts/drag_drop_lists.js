var lists = document.getElementsByName('list');

for (var i = 0; i < lists.length; i++) {
	var sort = Sortable.create(lists[i], {
		animation: 150,
		onUpdate: function (evt/**Event*/){
			console.log("onUpdate");
			var item = evt.item;
		}
		onEnd: function (evt/**Event*/) {
			console.log("onEnd");
			console.log(sort.toArray())
		}
	});
}	
