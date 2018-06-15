var lists = document.getElementsByName('list');
console.log(lists);

for (var i = 0; i < lists.length; i++) {
	Sortable.create(lists[i]);
}
