$(document).ready(function() {
  // Manually assign line-height based on container height.
  $(window).on('resize', function(e) {
    $('.valign').each(function(i) {
      $(this).css('line-height', $(this).height()+'px')
    });
  });

  // Force the initial line height.
  $(window).trigger('resize');

  // Update the date and time every second.
  setInterval(function() {
    var m = moment();
    $('header span.date').text(m.format('ddd MMM Do'))
    $('header span.time').text(m.format('h:mm A'))
  }, 1000);
});