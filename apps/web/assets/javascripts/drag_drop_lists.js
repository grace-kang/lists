var container = document.getElementById('list_container');
var csrf = document.getElementsByName('csrf');

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
	order = JSON.stringify(order);
	formData = new FormData();
	formData.append("_csrf_token", csrf[0].content);
	formData.append("order", order);

	var xhttp = new XMLHttpRequest();
	xhttp.open("POST", '/users/update_order', true);
	xhttp.send(formData);
}
