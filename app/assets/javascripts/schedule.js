
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
      let draggedFrom = $(ui.draggable[0]).parent();
      if (draggedFrom.find('.draggable').length === 2) {
        draggedFrom.hide();
      }
      let garden_classes = draggedFrom.attr('class');
      garden_class = garden_classes.split(' ')[0];
      let garden = $(this).find(`.${garden_class}`)
      if (garden.length == 0) {
        let emptyParent = draggedFrom.clone();
        emptyParent.find('.draggable').remove();
        $(this).append(emptyParent)
        garden = emptyParent
      }
      ui.draggable.detach().appendTo(garden);




      $(this).find(".no-waterings").hide();
      let id = ui.draggable[0].id
      let field = `#${id}-water-time`
      let date = this.parentElement.attributes.name.nodeValue
      $(field).val(date)
      $(`#update-${id}`).click();
    }
  });
});
