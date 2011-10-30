jQuery(function($) {
  $.ajaxSettings.dataType = 'json';
  $('.complaint')
    .bind('ajax:error', function(e, xhr, status, error) {
    })
    .bind('ajax:success', function(e, data, status, xhr) {
      alert('通報しました');
      return false;
    });
  $("#open-form").click(function(e) {
    $("#form-container").toggleClass("visible");
    return false;
  });
});
