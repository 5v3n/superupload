$(document).ready(function() {
  var form = $('.js-upload-form');
  var sid = new Date().getTime();
  //submit form when file has been selected
  $('.js-file-upload-input').on('change', function(){
    form.submit();
  });

  form.submit(function() {
    //'upload-target' is the name of the iframe
    document.getElementById('file-upload-form').target = 'upload-target'; 
    //add hidden field for params
    $('<input />').attr('type', 'hidden')
            .attr('name', 'sid')
            .attr('value', sid)
            .appendTo('.js-upload-form');
    $('.js-status').text('');
    $('.js-file-upload-progress').text('starting upload...');
    updateUploadProgress();
  });

  var updateUploadProgress = function() {
    console.log('checking progress...');
    // check upload progess
    $.get('/progress', {'uid': sid}, function(data) {
      console.log('data'+data);
      if(data.progress < 100) {
        if(data.progress) $('.js-file-upload-progress').text('uploading... ' + data.progress + '%');
        setTimeout('updateUploadProgress()',500);
        return true;
      }
      // if progress indicates upload complete, file info
      $('.js-status').text('Upload complete.');
      $('.js-file-upload-progress').text('');
    }, 'json');
  };
});