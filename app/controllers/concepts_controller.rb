class ConceptsController < ApplicationController
  def index
  end

  def one
    query = params[:query]
    ra_id = params[:research_area_id]

    @research_areas_options = ResearchArea.all
    build_form_elements_for_one

    build_research_area_by ra_id unless ra_id.blank?
    build_publication_by query unless query.blank?
  end

  private

  def build_form_elements_for_one
    @departments = []
    @researchers = []
    @venues = []
    @research_areas = []
    @publications = []
    @grants = []
    @patents = []
  end

  def build_research_area_by(ra_id)
    @research_area = ResearchArea.find_by_id(ra_id)
    @selected_name = @research_area.name

    @publications = @research_area.publications
    @researchers = @research_area.researchers.group(:id)
    @research_areas = @research_area.research_areas.group(:id)
    @grants = @research_area.grants
    @patents = @research_area.patents
    @departments = @research_area.departments.group(:id)
    @venues = @research_area.venues.group(:id)
  end

  def build_publication_by(query)
    @publication = Publication.where("name LIKE ?", "%#{query}%").first
    @selected_name = @publication.name

    @research_areas = @publication.research_areas
    @publications = @publication.publications.group(:id)
    @researchers = @publication.researchers
    @departments = @publication.departments.group(:id)
    @venues = [] << @publication.venue
    @patents = @publication.patents
    @grants = @publication.grants
  end
end
