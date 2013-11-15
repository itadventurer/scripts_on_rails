class ScriptsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  include ApplicationHelper

  def crumb
    add_crumb I18n.t('projects.my'), projects_path
    add_crumb @project.name, project_path(@project)
  end

  # GET /scripts
  # GET /scripts.json
  def index
    @project=Project.find(params[:project_id])
    @scripts = @project.scripts
    self.crumb
    authorize! :show, @project

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scripts }
    end
  end

  # GET /scripts/1
  # GET /scripts/1.json
  def show
    @project=Project.find(params[:project_id])
    self.crumb
    @script = @project.scripts.find(params[:id])
    add_crumb @script.name, project_script_path(@project,@script)
    authorize! :show, @script

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @script }
    end
  end

  # GET /scripts/new
  # GET /scripts/new.json
  def new
    @project=Project.find(params[:project_id])
    @script = @project.scripts.new
    self.crumb
    add_crumb I18n.t('scripts.new'), new_project_script_path(@project)
    authorize! :create, @script

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @script }
    end
  end

  # GET /scripts/1/edit
  def edit
    @project=Project.find(params[:project_id])
    self.crumb
    @script = @project.scripts.find(params[:id])
    add_crumb @script.name, project_script_path(@project,@script)
    add_crumb I18n.t('scripts.edit'), edit_project_script_path(@project,@script)
    authorize! :create, @script
  end

  # POST /scripts
  # POST /scripts.json
  def create
    @project=Project.find(params[:project_id])
    @script = @project.scripts.new(params[:script])

    respond_to do |format|
      if @script.save
        format.html { redirect_to project_script_path(@project,@script), notice: 'Script was successfully created.' }
        format.json { render json: @script, status: :created, location: @script }
      else
        format.html { render action: "new" }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scripts/1
  # PUT /scripts/1.json
  def update
  $request = request
    @project=Project.find(params[:project_id])
    @script = @project.scripts.find(params[:id])
    @script.update_code(params[:git][:code],params[:git][:message])

    respond_to do |format|
      if @script.update_attributes(params[:script])
        format.html { redirect_to edit_project_script_path(@project,@script), notice: 'Script was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scripts/1
  # DELETE /scripts/1.json
  def destroy
    @project=Project.find(params[:project_id])
    @script = @project.scripts.find(params[:id])
    @script.destroy

    respond_to do |format|
      format.html { redirect_to project_scripts_path(@project) }
      format.json { head :no_content }
    end
  end
  def run
    @project=Project.find(params[:project_id])
    self.crumb
    @script = @project.scripts.find(params[:script_id])
    add_crumb @script.name, project_script_path(@project,@script)
    add_crumb I18n.t('scripts.run'), edit_project_script_path(@project,@script)
    authorize! :run, @script
    @extraParams={}
    @script.getParams.each do |key,type|
      @script[key]=params[key] unless params[key].nil?
    end
  end
  def exec
    @project=Project.find(params[:project_id])
    self.crumb
    @script = @project.scripts.find(params[:script_id])
    authorize! :run, @script
    parameters=''
    user_params={}
    unless @project.members.find_by_user_id(current_user.id).vars.nil?
      @project.members.find_by_user_id(current_user.id).vars.split(',').each do |v|
        v=v.split(':')
        user_params[v[0]]=v[1] if v.length==2
      end
    end
    dir=nil # Delete the directory when finish the script execution
    @script.getParams.each do |key,type|
      key="" if key.nil?
      parameters+=' --' + key.gsub(/[^a-zA-Z_]/u,'') + '='
      k=key.to_sym
      case type
      when 'date'
        if (not params[k].nil?) and params[k].match(/^\d{4}\-\d{2}\-\d{2}$/)
          parameters+=params[k] 
        end
      when 'user'
        parameters+=user_params[key] unless user_params[key].nil?
      when 'file'
        if (not params[k].nil?) and params[k]!=""
          dir=Dir.mktmpdir
          uploaded_io = params[k]
          File.open("#{dir}/#{uploaded_io.original_filename}",'w') do |file|
            file.binmode
            file.write(uploaded_io.read)
            parameters+=" " + file.path
          end
        end
      else
        parameters+=params[k].gsub(/[^ a-zA-Z0-9,\.\-_]/u,'') unless params[k].nil?
      end
    end

    path=@script.getPath
    beginning = Time.now
    if path.exist?
      data=`PYTHONPATH=/var/www/scripts_on_rails_new/git/lib '#{path.realpath}' #{parameters} 2>&1`
    else
      data="File not found!"
    end

    FileUtils.remove_entry_secure dir unless dir.nil?
    time=Time.now-beginning

    require 'redcarpet'
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => true, :space_after_headers => true)
    md=markdown.render(data)
    json={"data"=>data,"time"=>time,"markdown"=>md}
    render json: json

  end
end
