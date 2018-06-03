var subitem_button = document.getElementsByName("subitem_button");
var subitem_form = document.getElementsByName("subitem_form");

addEventListener("click", function(event){
  var isClickInside = false;
  var index;

  for (var i = 0; i < subitem_button.length; i++) {
    if (subitem_button[i].contains(event.target)) {
      isClickInside = true;
      index = i;
    }
  }
   
  for (var i = 0; i < subitem_form.length; i++) {
    if (subitem_form[i].contains(event.target)) {
      isClickInside = true;
      index = i;
    }
  }

    
  if (isClickInside) {
    hide(subitem_button[index]);
    show(subitem_form[index]);
  } else {
    subitem_button.forEach(show);
    subitem_form.forEach(hide);
  }
});

function show(item) {
  item.style.display="block";
}
 
function hide(item) {
  item.style.display="none";
}