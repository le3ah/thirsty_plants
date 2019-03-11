
$( document ).ready(function() {
  $('.plant-check-icon').click(function() {
    let iconImage = $(this).children('img');
    let id = $(this).data('id');
    let field = $(`#watering-${id}-completed`)
    let toggledValue = field.val() == "false" ? "true" : "false";
    $(iconImage).toggleClass("watered-plant-image")
    $(field).val(toggledValue) // we still need this given how we're getting toggledValue
    $(`#watering-${id}-name`).toggleClass("watered-plant-name");
    updateWatering(id, {completed: toggledValue})
  });

  $( ".draggable" ).draggable({
    helper:"clone",
    containment:"document"
  });

  $( ".droppable" ).droppable({
    tolerance: 'touch',
    drop: function( event, ui ) {
      let draggedFrom = $(ui.draggable[0]).parent();
      if($(this).attr('id') === draggedFrom.parent().attr('id')) { return true }
      let garden_classes = draggedFrom.attr('class');
      garden_class = garden_classes.split(' ')[0];
      let garden = $(this).find(`.${garden_class}`)
      if (garden.length == 0) {
        let emptyParent = draggedFrom.clone();
        emptyParent.find('.watering').remove();
        $(this).append(emptyParent)
        garden = emptyParent
      }
      if (draggedFrom.find('.watering').length === 2) {
        draggedFrom.detach();
      }
      ui.draggable.appendTo(garden);

      $(this).find(".no-waterings").hide();

      let id = ui.draggable[0].id.split('-')[1]
      let date = this.parentElement.attributes.name.nodeValue
      updateWatering(id, {water_time: date})
    }
  });
});

const updateWatering = (id, attributes) => {
  let params = {watering: attributes}
  fetch(`/waterings/${id}?`, {
    method: 'PATCH',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(params)
  });
}
