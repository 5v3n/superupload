$('.js-upload-form').each( function(){
  var file= document.getElementById('file-upload-input');
  var submit= document.getElementById('file-upload-submit');
  var status = $('#status');
  var progress = $('#file-upload-progress');


  $(this).ajaxForm({
    beforeSend: function() {
        progress.empty();
        status.empty();
        progress.html('Uploaded 0%');
        progress.show();
    },
    uploadProgress: function(event, position, total, percentComplete) {
        var percentVal = percentComplete + '%';
        progress.html('Uploaded ' + percentVal);
        //console.log(percentVal, position, total);
    },
    complete: function(xhr) {
      progress.empty();
      if(xhr.status === 201){
        status.html('Upload is complete.');
      }
      else{
        status.html(xhr.status + ': ' + xhr.statusText);
      }

    }
  });
      // When field is filled in with a filename, submit form
    //
    file.onchange= function() {
        if (this.value!=='')
            submit.click();
    }; 
});