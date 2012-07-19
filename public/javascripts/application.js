window.SuperUpload = window.SuperUpload || {};

$(document).ready(function() {
  var form = $('.js-upload-form');
  var sid = new Date().getTime();
  //submit form when file has been selected
  $('.js-file-upload-input').on('change', function(){
    form.submit();
  });

  form.submit(function() {
    //use hidden iframe for upload
    $('#file-upload-form').attr('target', 'upload-target'); 
    //add sid to action
    $(this).attr('action', '/uploads?sid=' + sid);
    $('.js-status').text('starting upload...');
    window.SuperUpload.updateUploadProgress(sid);
  });
});

window.SuperUpload.updateUploadProgress = function(sid) {
    // check upload progess
    $.get('/progress?sid=' + sid, function(data) {
      var progress = data.progress || 0
      if(progress < 100) {
        if(progress) $('.js-status').text('Status: ' + progress + '%.');
        setTimeout(function(){window.SuperUpload.updateUploadProgress(sid)},500);
        return true;
      }
      // if progress indicates upload complete, file info
      $('.js-status').html('Status: 100%. <a href="'+data.path+'">Find it here.</a>');
    }, 'json');
  };