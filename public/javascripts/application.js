window.SuperUpload = window.SuperUpload || {};

$(document).ready(function() {
  var form = $('.js-upload-form');
  var sid = new Date().getTime();
  //submit form when file has been selected
  $('.js-file-upload-input').on('change', function(){
    form.submit();
  });

  form.submit(function() {
    var fileName = 'xyz_' + sid;
    //use hidden iframe for upload
    $('#file-upload-form').attr('target', 'upload-target'); 
    //add sid to action
    $(this).attr('action', '/uploads?sid=' + sid + '&filename=' + fileName);
    $('.js-status').text('');
    $('.js-file-upload-progress').text('starting upload...');
    window.SuperUpload.updateUploadProgress(sid);
  });
});

window.SuperUpload.updateUploadProgress = function(sid) {
    console.log('checking progress for sid ' + sid + '...');
    // check upload progess
    $.get('/progress?sid=' + sid, function(data) {
      console.log(data);
      var progress = data.progress || 0
      if(progress < 100) {
        if(progress) $('.js-file-upload-progress').text('uploading... ' + progress + '%');
        setTimeout('window.SuperUpload.updateUploadProgress('+sid+')',500);
        return true;
      }
      // if progress indicates upload complete, file info
      $('.js-status').text('Upload complete.');
      $('.js-file-upload-progress').text('');
    }, 'json');
  };