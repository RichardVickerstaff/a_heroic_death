//= require jquery

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



  $("#button").click(function () {
    if( pin.toString() == ["1", "2", "3", "4"].toString() ) {
      $(".locked_wrapper").each(function () {
        $(this).addClass('hidden');
      });
      $(".unlocked_wrapper").each(function () {
        $(this).removeClass('hidden');
      });
    } else {
      $($(".numberinput").get().reverse()).each(function () {
        $(this).text("");
        $(this).removeClass("nocircle");
        pin = [];
      });
    }
  });
});
