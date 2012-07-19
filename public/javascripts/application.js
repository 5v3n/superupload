window.SuperUpload = window.SuperUpload || {};

$(document).ready(function() {
  var form = $('.js-upload-form');
  var sid = new Date().getTime();
  var interval = null;
  //submit form when file has been selected
  $('.js-file-upload-input').on('change', function(){
    form.submit();
    interval = setInterval(function(){
      $.getJSON('/progress?sid=' + sid, function(data) {
        var progress = data.progress;
        if(progress < 100) {
          $('.js-status').text('Status: ' + progress + '%.');
        }
        else{
          $('.js-status').html('Status: 100%. <a href="'+data.path+'">Find it here.</a>');
          clearInterval(interval);
        }
      })
    }, 1000);
  });

  form.submit(function() {
    //use hidden iframe for upload
    $('#file-upload-form').attr('target', 'upload-target'); 
    //add sid to action
    $(this).attr('action', '/uploads?sid=' + sid);
    $('.js-status').text('starting upload...');
  });
});

