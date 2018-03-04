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

  function getTimeRemaining(endtime) {
    var t = Date.parse(endtime) - Date.parse(new Date());
    var seconds = Math.floor((t / 1000) % 60);
    var minutes = Math.floor((t / 1000 / 60) % 60);
    var hours = Math.floor((t / (1000 * 60 * 60)) % 24);
    var days = Math.floor(t / (1000 * 60 * 60 * 24));
    return {
      'total': t,
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds
    };
  }

  function initializeClock(id, endtime) {
    var clock = document.getElementById(id);
    var daysSpan = clock.querySelector('.days');
    var hoursSpan = clock.querySelector('.hours');
    var minutesSpan = clock.querySelector('.minutes');
    var secondsSpan = clock.querySelector('.seconds');

    function updateClock() {
      var t = getTimeRemaining(endtime);

      daysSpan.innerHTML = t.days;
      hoursSpan.innerHTML = ('0' + t.hours).slice(-2);
      minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
      secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);

      if (t.total <= 0) {
        clearInterval(timeinterval);
      }
    }

    updateClock();
    var timeinterval = setInterval(updateClock, 1000);
  }

  var timeInMinutes = 240;
  var currentTime = Date.parse(new Date());
  var deadline = new Date(currentTime + timeInMinutes*60*1000);
  initializeClock('clockdiv', deadline);
});
