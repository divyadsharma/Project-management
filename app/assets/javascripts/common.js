$(document).on('turbolinks:load', function() {
  $(document).on('keypress', 'input.number', function(e){
    if (e.which != 0 && e.which != 8 && e.which != 9 && e.which != 39 && e.which != 46 && (e.which < 48 || e.which > 57)) {
      return false;
    }
  });

  $(document).on('keypress', 'input.digit', function(e){
    if (e.which != 8 && e.which != 9 && e.which != 39 && (e.which < 48 || e.which > 57)) {
      return false;
    }
  });

  setTimeout(function(){
    $('.flash_messages_div').slideUp('slow');
  }, 4000);
});
