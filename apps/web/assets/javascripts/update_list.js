var list_name = document.getElementsByName("list_name");
var list_form = document.getElementsByName("list_form");
var delete_list = document.getElementsByName("delete_list");
var rename_list = document.getElementsByName("rename_list");

addEventListener("click", function(event) {
  var isClickInside = false;
  var index;

  for (var i = 0; i < rename_list.length; i++) {
    if (rename_list[i].contains(event.target)) {
      isClickInside = true;
      index = i;
    }
  }

  for (var i = 0; i < list_form.length; i++) {
    if (list_form[i].contains(event.target)) {
      isClickInside = true;
      index = i;
    }
  }

  if (isClickInside) {
    hide(list_name[index]);
    show(list_form[index]);
    hide(delete_list[index]); 
    hide(rename_list[index]);
  } else {
    list_name.forEach(show);
    list_form.forEach(hide);
    delete_list.forEach(show); 
    rename_list.forEach(show);
  }
});

function show(item) {
  item.style.display="block";
}

function hide(item) {
  item.style.display="none";
}
