$( document ).ready(function() {
  $('#user_receives_texts').click(function() {
    if ($(this).prop('checked')) {
      $('#toggleable-phone-field').show();
    } else {
      $('#toggleable-phone-field').hide();
      $('#user_telephone').val('');
    }
  });
  $('input').click(function() {
    if ($('#user_receives_texts').prop('checked') == true || $('#user_receives_emails').prop('checked') == true) {
      $('#toggable-notication-inputs').show();
    } else {
      $('#toggable-notication-inputs').hide();
    }
  });
});
