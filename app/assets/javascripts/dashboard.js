$(function(){

  $('.cupboard-remove').click(function(e){
    var table_row = $(this).parents('tr');
    table_row.fadeToggle('slow');
    removeIngredient(this);
    return false;
  });

  $('.shopping-list-remove').click(function(e){
    var table_row = $(this).parents('tr');
    table_row.fadeToggle('slow');
    removeIngredient(this);
    return false;
  });

  function removeIngredient(element){
    $.ajax({
      type: 'DELETE',
      url: $(element).attr('href')
    });
  }

});

