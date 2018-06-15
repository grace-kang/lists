var container = document.getElementById('list_container');

var sort = Sortable.create(container, {
	animation: 150,
	draggable: ".list",
	onUpdate: function (evt/**Event*/){
		order = sort.toArray();
		order_hash = {};
		for (var i = 0; i < order.length; i++) {
			order_hash[order[i]] = i;
		}
		updateOrder(order_hash);
	}
});
	
function updateOrder(order) {
	console.log("updateOrder()")
	var xhttp = new XMLHttpRequest();
	xhttp.open("POST", '/users/update_order', true);
	xhttp.send(order);
	console.log("order sent");
}
