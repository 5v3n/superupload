$(document).ready(function() {
  var form = $('.js-upload-form');
  var sid = '1234'
  //submit form when file has been selected
  $('#file-upload-input').on('change', function(){
    form.submit();
  });

  form.submit(function() {
    console.log(this);
    //add hidden field for params
    $('<input />').attr('type', 'hidden')
            .attr('sid', sid)
            .appendTo('.js-upload-form');
    $('#status').text('');
    $('#progress').text('starting upload...');
    updateUploadProgress();
  });

  var updateUploadProgress = function() {
    // check upload progess
    $.get('/progress', {'uid': sid}, function(data) {
      if(data.progress < 100) {
        if(data.progress) $('#progress').text('uploading... ' + data.progress + '%');
        setTimeout('updateUploadProgress()',500);
        return true;
      }
      // if progress indicates upload complete, file info
      //getStatus();
    }, 'json');
  };
});