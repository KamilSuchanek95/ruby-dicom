class ExaminationsController < ApplicationController
  # GET /examinations
  # GET /examinations.xml
  def index
    #@examinations = Examination.all
	  @examinations = Examination.find(:all)
  	@study = params[:study]
  	@mean_exposure = Examination.average(:exposure, :conditions => ['study == ?', @study]) if @study

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examinations }
    end
  end

  # GET /examinations/1
  # GET /examinations/1.xml
  def show
    @examination = Examination.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @examination }
    end
  end

  # GET /examinations/new
  # GET /examinations/new.xml
  def new
    @examination = Examination.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examination }
    end
  end

  # GET /examinations/1/edit
  def edit
    @examination = Examination.find(params[:id])
  end

  # POST /examinations
  # POST /examinations.xml
  def create
    @examination = Examination.new(params[:examination])

    respond_to do |format|
      if @examination.save
        format.html { redirect_to(@examination, :notice => 'Examination was successfully created.') }
        format.xml  { render :xml => @examination, :status => :created, :location => @examination }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examination.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examinations/1
  # PUT /examinations/1.xml
  def update
    @examination = Examination.find(params[:id])

    respond_to do |format|
      if @examination.update_attributes(params[:examination])
        format.html { redirect_to(@examination, :notice => 'Examination was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examination.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examinations/1
  # DELETE /examinations/1.xml
  def destroy
    @examination = Examination.find(params[:id])
    @examination.destroy

    respond_to do |format|
      format.html { redirect_to(examinations_url) }
      format.xml  { head :ok }
    end
  end
end
