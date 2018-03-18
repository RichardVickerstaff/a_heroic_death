import $ from 'jquery'

$(function () {
  var pin = [];

  $(".content").click(function () {

    var value = $(this).find(".number").text();

    if (value !== "<") {
      $(".numberinput").each(function () {
        var a = $(this).text();
        if (!a) {
          $(this).text(value);
          $(this).addClass("nocircle");
          pin.push(value);
          return false;
        }
      });
    } else {
      $($(".numberinput").get().reverse()).each(function () {
        var a = $(this).text();
        if (a) {
          $(this).text("");
          $(this).removeClass("nocircle");
          pin.pop();
          return false;
        }
      });
    }
  });

  var reset = function() {
    $($(".numberinput").get().reverse()).each(function () {
      $(this).text("");
      $(this).removeClass("nocircle");
      pin = [];
    });
  };


  $("#button").click(function () {
    $.ajax({
      type: "POST",
      url: "/api",
      data: JSON.stringify(pin),
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(){
        reset();},
      failure: function(){
        reset();},
      error: function(){
        reset();}
    });
  });

});
