$( document ).ready(function() {
  $('#user_receive_texts').click(function() {
    if ($(this).prop('checked')) {
      $('#toggleable-phone-field').show();
    } else {
      $('#toggleable-phone-field').hide();
    }
  });
  $('input').click(function() {
    if ($('#user_receive_texts').prop('checked') == true || $('#user_receive_emails').prop('checked') == true) {
      $('#toggable-notication-inputs').show();
    } else {
      $('#toggable-notication-inputs').hide();
    }
  });
});
