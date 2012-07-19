window.SuperUpload = window.SuperUpload || {};

//teken from http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript
window.SuperUpload.genereateSid = function(){
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
    return v.toString(16);
  });
};

$(document).ready(function() {
  var uploadForm = $('.js-upload-form');
  var commentForm = $('.js-comment-form');
  var sid = window.SuperUpload.genereateSid();
  var interval = null;

  commentForm.hide();
  //submit form when file has been selected
  $('.js-file-upload-input').on('change', function(){
    uploadForm.submit();
    interval = setInterval(function(){
      $.getJSON('/progress?sid=' + sid, function(data) {
        var progress = data.progress;
        if(progress < 100) {
          $('.js-status').text('Status: ' + progress + '%.');
        }
        else{
          $('.js-status').html('Status: 100%. <a href="'+data.path+'">Uploaded to here.</a>');
          clearInterval(interval);
          commentForm.show();
        }
      })
    }, 1000);
  });

  uploadForm.submit(function() {
    //use hidden iframe for upload
    $(this).attr('target', 'upload-target'); 
    //add sid to action
    $(this).attr('action', '/uploads?sid=' + sid);
    commentForm.attr('action', '/comments?sid=' + sid);
    $('.js-status').text('starting upload...');
  });
});

