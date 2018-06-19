var list_container = document.getElementById('list_container');
var item_container = document.getElementsByName('item_container');
var subitem_container = document.getElementsByName('subitem_container');
var csrf = document.getElementsByName('csrf');

var lists = Sortable.create(list_container, {
  animation: 150,
  draggable: ".list",
  onUpdate: function (evt/**Event*/){
    var list_order = Sortable.active.toArray();
    var list_order_hash = {};
    for (var i = 0; i < list_order.length; i++) {
      list_order_hash[list_order[i]] = i;
    }
    updateLists(list_order_hash);
	}
});

for (var i = 0; i < item_container.length; i++) {
	var items = Sortable.create(item_container[i], {
		animation: 150,
		draggable: ".item",
		onUpdate: function (evt/**Event*/){
			var item_order = Sortable.active.toArray();
			var item_order_hash = {};
			for (var i = 0; i < item_order.length; i++) {
				item_order_hash[item_order[i]] = i;
			}
			updateItems(item_order_hash);
		}
	});
}

for (var i = 0; i < subitem_container.length; i++) {
	var subitems = Sortable.create(subitem_container[i], {
		animation: 150,
		draggable: ".subitem",
		onUpdate: function (evt/**Event*/){
			var subitem_order = Sortable.active.toArray();
			var subitem_order_hash = {};
			for (var i = 0; i < subitem_order.length; i++) {
				subitem_order_hash[subitem_order[i]] = i;
			}
			updateSubitems(subitem_order_hash);
		}
	});
}

function updateLists(order) {
	console.log(order);
  var order = JSON.stringify(order);                                     
  var formData = new FormData();                                         
  formData.append("_csrf_token", csrf[0].content);                   
  formData.append("order", order);                                   
                                                                     
  var xhttp = new XMLHttpRequest();                                  
  xhttp.open("POST", '/users/update_order', true);                   
  xhttp.send(formData);                                              
}                                                                    

function updateItems(order) {
  console.log(order);
  var order = JSON.stringify(order);
  var formData = new FormData();
  formData.append("_csrf_token", csrf[0].content);
  formData.append("order", order);

  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", '/lists/update_order', true);
  xhttp.send(formData);
}



function updateSubitems(order) {
	console.log(order);
  var order = JSON.stringify(order);
  var formData = new FormData();
  formData.append("_csrf_token", csrf[0].content);
  formData.append("order", order);

  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", '/items/update_order', true);
  xhttp.send(formData);
}

