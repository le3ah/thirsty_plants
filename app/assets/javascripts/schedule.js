
$( document ).ready(function() {
    $('.plant-check-icon').click(function() {
      let iconImage = $(this).children('img');
      let id = $(this).data('id');
      let field = $(`#watering-${id}-completed`)
      let toggledValue = field.val() == "false" ? "true" : "false";

      $(iconImage).toggleClass("watered-plant-image")
      $(field).val(toggledValue)
      $(`#watering-${id}-name`).toggleClass("watered-plant-name");
      $(`#update-watering-${id}`).click();
    });
});
