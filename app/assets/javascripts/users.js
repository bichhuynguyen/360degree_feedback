$('#list').live('change',function(){
  $.ajax({
    url: "find/list",
    type: "GET",
    data: {'team=' + $('#list option:selected').value() },
  })
});