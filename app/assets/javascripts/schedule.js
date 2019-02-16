
$( document ).ready(function() {
    $('.plant_icon').click(function() {
      let id = $(this).data('id');
      let field = $(`#watering-${id}-completed`)
      let toggledValue = field.val() == "false" ? "true" : "false";

      $(field).val(toggledValue)
      $(`#watering-${id}-name`).toggleClass("watered-plant-name");
      $(`#update-watering-${id}`).click();
    });
});
