class PatentsController < ApplicationController
  # GET /patents
  # GET /patents.json
  def index
    @patents = Patent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patents }
    end
  end

  # GET /patents/1
  # GET /patents/1.json
  def show
    @patent = Patent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patent }
    end
  end

  # GET /patents/new
  # GET /patents/new.json
  def new
    @patent = Patent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patent }
    end
  end

  # GET /patents/1/edit
  def edit
    @patent = Patent.find(params[:id])
  end

  # POST /patents
  # POST /patents.json
  def create
    @patent = Patent.new(params[:patent])

    respond_to do |format|
      if @patent.save
        format.html { redirect_to @patent, notice: 'Patent was successfully created.' }
        format.json { render json: @patent, status: :created, location: @patent }
      else
        format.html { render action: "new" }
        format.json { render json: @patent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /patents/1
  # PUT /patents/1.json
  def update
    @patent = Patent.find(params[:id])

    respond_to do |format|
      if params[:patent][:research_areas]
        research_area = ResearchArea.find(params[:patent][:research_areas].to_i)
        @patent.research_areas << research_area
        @patent.save
        format.json { render json: research_area }
      elsif @patent.update_attributes(params[:patent])
        format.html { redirect_to @patent, notice: 'Patent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @patent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patents/1
  # DELETE /patents/1.json
  def destroy
    @patent = Patent.find(params[:id])
    @patent.destroy

    respond_to do |format|
      format.html { redirect_to patents_url }
      format.json { head :no_content }
    end
  end
end
