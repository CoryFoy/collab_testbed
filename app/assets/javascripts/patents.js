$(document).ready(function(){
    $("#research-area-add-form")
    .live("ajax:success", 
      function(data, status, xhr) { 
        $('#research-areas').append("<li>" + status['name'] + "</li>"); 
      });
    });
