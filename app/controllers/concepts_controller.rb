class ConceptsController < ApplicationController
  def index
  end

  def one
    query = params[:query]
    ra_id = params[:research_area_id]

    build_form_elements_for_one

    unless ra_id.nil?
      @research_area = ResearchArea.find_by_id(ra_id)

      @publications = @research_area.publications
      @researchers = @research_area.researchers.group(:id)
      @research_areas = @research_area.research_areas.group(:id)
      @grants = @research_area.grants
      @patents = @research_area.patents
      @departments = @research_area.departments.group(:id)
      @venues = @research_area.venues.group(:id)
    end
  end

  private

  def build_form_elements_for_one
    @research_areas_options = ResearchArea.all

    @departments = []
    @researchers = []
    @venues = []
    @research_areas = []
    @publications = []
    @grants = []
    @patents = []
  end

end
