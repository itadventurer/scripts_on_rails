// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap
//= require js-routes
//= require_tree .
waitcount=0;
addWait=function(){
  if(waitcount==0)
    $('#ide-run i').html('<img src="/assets/ajax-loader.gif" />');
  waitcount++;
}
subWait=function(){
  waitcount--;
  if(waitcount<=0)
    $('#ide-run i').empty();
}

run=function(){
  addWait();
  $.get(Routes.project_script_exec_path(project_id,script_id), function(data){
    $('#ide-console-content').append('<strong>Script:</strong> ' + script_name + ' <strong>Time:</strong> ' + data.time + '<pre>' + data.data + '</pre>');
    subWait();
  });
};
$(function(){
  $('#ide-nav .script a').click(function(e){
    e.preventDefault();
    that=this
    $.get(Routes.project_script_path(project_id,$(this).attr('script_id')),function(data){
      script_id=data.id;
      script_name=data.name;
      ide_editor.setValue(data.code);
      $('#ide-nav .script').removeClass('active');
      $(that).parent().addClass('active');
    });
  });
  safe_bgc=$('#ide-save').css('backgroundColor');
  $('#ide-save').click(function(e){
    e.preventDefault();
    $.ajax({
      type:'put',
      dataType:'json',
      url:Routes.project_script_path(project_id,script_id),
      data:{
        script:{
          code:ide_editor.getValue()
        }
      },
      success: function(data){
        $('#ide-save').animate({backgroundColor:'green'},500).animate({backgroundColor:safe_bgc},500);
      }
    });
  });
  $('#ide-run').click(function(e){
    e.preventDefault();
    run();
  });
  $('#ide-clean').click(function(e){
    e.preventDefault();
    $('#ide-console-content').empty();
  });
  $('#ide-close').click(function(e){
    e.preventDefault();
    $('#ide').hide();
  });
  $('#ide-fullscreen').click(function(e){
    window.addEventListener("beforeunload", function (e) {
      var confirmationMessage = "";

      (e || window.event).returnValue = confirmationMessage;     //Gecko + IE
      return confirmationMessage;                                //Webkit, Safari, Chrome etc.
    });
    e.preventDefault();
    $('#ide').show();
  });
  $('.param_date').datepicker();
});
