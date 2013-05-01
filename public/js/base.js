$(document).ready(function() {
  // 
  $(window).on('resize', function(e) {
    $('.valign').each(function(i) {
      $(this).css('line-height', $(this).height()+'px')
    });
  });

  $(window).trigger('resize');

  // Update the time
  setInterval(function() {
    $('header span.date').text(moment().format('ddd MMM Do'))
    $('header span.time').text(moment().format('h:mm A'))
  }, 1000);
});