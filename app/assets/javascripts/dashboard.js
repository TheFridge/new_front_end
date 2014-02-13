$(function(){

  $('.cupboard-remove').click(function(e){
    var table_row = $(this).parents('tr');
    table_row.fadeToggle('slow');
    removeIngredient(this);
    updateCount();
    return false;
  });

  $('.shopping-list-remove').click(function(e){
    var table_row = $(this).parents('tr');
    table_row.fadeToggle('slow');
    removeIngredient(this);
    updateCount();
    return false;
  });

  function removeIngredient(element){
    $.ajax({
      type: 'DELETE',
      url: $(element).attr('href')
    });
  }

  function updateCount(){
    var count = $('.list-count').text();
    count = count - 1;
    $('.list-count').text(count);
  }

});

