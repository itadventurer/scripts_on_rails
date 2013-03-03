class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def crumb
    add_crumb I18n.t('projects.my'), projects_path
  end
  
  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
    self.crumb

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  def all
    @projects=Project.all
    self.crumb
    authorize! :list_all, Project
    render 'index'
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    self.crumb
    add_crumb @project.name, project_path(@project)

    respond_to do |format|
      format.html { redirect_to project_scripts_path(@project) }# show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    self.crumb
    add_crumb I18n.t('projects.new'), new_project_path()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    self.crumb
    add_crumb @project.name, project_path(@project)
    add_crumb I18n.t('projects.edit'), edit_project_path(@project)
    authorize! :update, @project
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    m=@project.members.new
    m.user=current_user
    m.is_admin=true
    m.can_create=true
    m.save

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
