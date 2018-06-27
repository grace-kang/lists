import React from 'react';
import ReactDOM from 'react-dom';


function ListContainer(props) {
  const lists = props.lists;
  const listLists = lists.map((list) =>
    <li>{list}</li>
  );
  return (
    <ul>{listLists}</ul>
  );
}


const user_id = document.getElementById('user_id').innerHTML;
const csrf = document.getElementsByName('csrf')[0].content;
const list_array = getLists(user_id);
console.log(user_id);
console.log(list_array);

ReactDOM.render(
	<ListContainer lists={list_array} />,
	document.getElementById('root')
);

function getLists(user_id) {
	var formData = new FormData();
	formData.append("_csrf_token", csrf);

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			return this.responseText;
		}
	};
			
	xhttp.open("GET", "/api/lists/index/" + user_id, true);
	xhttp.send(formData);
}
	
