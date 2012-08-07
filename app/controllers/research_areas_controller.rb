class ResearchAreasController < ApplicationController
  # GET /research_areas
  # GET /research_areas.json
  def index
    @research_areas = ResearchArea.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @research_areas }
    end
  end

  # GET /research_areas/1
  # GET /research_areas/1.json
  def show
    @research_area = ResearchArea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @research_area }
    end
  end

  # GET /research_areas/new
  # GET /research_areas/new.json
  def new
    @research_area = ResearchArea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @research_area }
    end
  end

  # GET /research_areas/1/edit
  def edit
    @research_area = ResearchArea.find(params[:id])
  end

  # POST /research_areas
  # POST /research_areas.json
  def create
    @research_area = ResearchArea.new(params[:research_area])

    respond_to do |format|
      if @research_area.save
        format.html { redirect_to @research_area, notice: 'Research area was successfully created.' }
        format.json { render json: @research_area, status: :created, location: @research_area }
      else
        format.html { render action: "new" }
        format.json { render json: @research_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /research_areas/1
  # PUT /research_areas/1.json
  def update
    @research_area = ResearchArea.find(params[:id])

    respond_to do |format|
      if @research_area.update_attributes(params[:research_area])
        format.html { redirect_to @research_area, notice: 'Research area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @research_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /research_areas/1
  # DELETE /research_areas/1.json
  def destroy
    @research_area = ResearchArea.find(params[:id])
    @research_area.destroy

    respond_to do |format|
      format.html { redirect_to research_areas_url }
      format.json { head :no_content }
    end
  end
end
