
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

    $( ".draggable" ).draggable({
      helper:"clone",
      containment:"document"
    });

    $( ".droppable" ).droppable({
      tolerance: 'touch',
      drop: function( event, ui ) {
        debugger;
        ui.draggable.detach().appendTo(this);
        $(this).find(".no-waterings").hide();
        let id = ui.draggable[0].id
        let field = `#${id}-water-time`
        let date = this.parentElement.attributes.name.nodeValue
        $(field).val(date)
        $(`#update-${id}`).click();
      }
    });
});
