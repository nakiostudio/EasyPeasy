$(document).ready(function() {
    $(".target-details").click(function() {
      var file_id = "#" + $(this).attr("target-id");
      $(file_id).slideToggle();
    });

   $(".file-row").click(function() {
     var file_id = "#" + $(this).attr("file-id");
     $(file_id).slideToggle();
   });
 });
