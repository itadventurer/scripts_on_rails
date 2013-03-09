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

Script=function(id,callback){
  // Functions
  this.id=id;
  this.data=null;
  this.lastLine=1;
  this.lastVisibleLine=0;
  this.update=function(callback){
    that=this;
    $.get(Routes.project_script_path(project_id,id),function(data){
      that.data=data;
      callback(that);
    });
  };
  this.getCode=function(){
    return this.data.code;
  }
  this.getName=function(){
    return this.data.name;
  }
  this.setCode=function(code){
    this.data.code=code;
  }
  this.save=function(callback){
    $.ajax({
      type:'put',
      dataType:'json',
      url:Routes.project_script_path(project_id,id),
      data:{
        script:{
          code:this.data.code
        }
      },
      success: callback
    });
  }
  this.run=function(callback){
    $.get(Routes.project_script_exec_path(project_id,this.id), callback);
  }
  // "Constructor"
  this.update(callback);
}


Scripts={
  scripts:{},

  run:function(callback){
    addWait();
    $.get(Routes.project_script_exec_path(project_id,script_id), callback);
  },

  updateScript:function(id){
    $.get(Routes.project_script_path(project_id,id),function(data){
      Scripts.scripts[data.id]=data;
      script_id=data.id;
      script_name=data.name;
      ide_editor.setValue(data.code);
    });
  },

  saveScript:function(id,onSuccess){
    $.ajax({
      type:'put',
    dataType:'json',
    url:Routes.project_script_path(project_id,id),
    data:{
      script:{
        code:Scripts.scripts[id].code
      }
    },
    success: onSuccess
    });
  }
}
