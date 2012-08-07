$(document).ready(function(){
    $("#researcher-add-form")
    .live("ajax:success", 
      function(data, status, xhr) { 
        $('#researchers').append("<li>" + status['name'] + "</li>"); 
      });
    $("#research-area-add-form")
    .live("ajax:success", 
      function(data, status, xhr) { 
        $('#research-areas').append("<li>" + status['name'] + "</li>"); 
      });
    });
