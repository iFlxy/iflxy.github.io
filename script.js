function vh(percent) {
  var h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
  return (percent * h) / 100;
}

$(document).mousemove(function(e) {
  $("#follow").css({
    left: e.pageX - vh(30),
    top: e.pageY - vh(30)
  });
});