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

$.datepicker.setDefaults({
  dateFormat:"yy-mm-dd"
});
$(function(){
  scripts={};
  change_active=true;
  scripts[script_id]=new Script(script_id,function(){});


  // OnChange
  ide_editor.getSession().on('change', function(e) {
    if(change_active)
      $('#ide-nav .active .edited').show();
  });

  // Open Script
  $('#ide-nav .script a').click(function(e){
    e.preventDefault();
    var id=$(this).attr('script_id');
    scripts[script_id].setCode(ide_editor.getValue());
    scripts[script_id].lastLine=ide_editor.selection.getCursor();
    scripts[script_id].lastVisibleLine=ide_editor.getFirstVisibleRow();
    script_id=id;
    change_active=false;
    callback=function(script){
        ide_editor.setValue(script.getCode());
        ide_editor.navigateTo(script.lastLine.row,script.lastLine.column);
        ide_editor.scrollToLine(script.lastVisibleLine);
        ide_editor.focus();
        change_active=true;
    }
    if(typeof(scripts[id])=='undefined'){
      scripts[id]=new Script(id,function(script){
        callback(script);
      });
    } else {
      callback(scripts[id]);
    }
    $('#ide-nav .script').removeClass('active');
    $(this).parent().addClass('active');
  });

  // Safe Script
  safe_bgc=$('#ide-save').css('backgroundColor');
  $('#ide-save').click(function(e){
    scripts[script_id].setCode(ide_editor.getValue());
    scripts[script_id].save(function(data){
      $('#ide-save').animate({backgroundColor:'green'},500).animate({backgroundColor:safe_bgc},500);
    });
    $('#ide-nav .active .edited').hide();
    e.preventDefault();
  });

  // Run
  $('#ide-run').click(function(e){
    e.preventDefault();
    Scripts.run(function(data){
      $('#ide-console-content').append('<strong>Script:</strong> ' + scripts[script_id].getName() + ' <strong>Time:</strong> ' + data.time + '<pre>' + data.data + '</pre>');
      subWait();
    });
  });

  // Clean console
  $('#ide-clean').click(function(e){
    e.preventDefault();
    $('#ide-console-content').empty();
  });

  // Close ide
  $('#ide-close').click(function(e){
    e.preventDefault();
    $('#ide').hide();
  });

  // Open IDE
  $('#ide-fullscreen').click(function(e){
    /* window.addEventListener("beforeunload", function (e) {
       var confirmationMessage = "";

       (e || window.event).returnValue = confirmationMessage;     //Gecko + IE
       return confirmationMessage;                                //Webkit, Safari, Chrome etc.
       });*/
    e.preventDefault();
    $('#ide').show();
  });

  // Datepicker
  $('.param_date').datepicker();
});
