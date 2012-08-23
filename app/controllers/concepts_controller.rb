class ConceptsController < ApplicationController
  def index
  end

  def one
    query = params[:query]
    ra_id = params[:research_area_id]

    @research_areas_options = ResearchArea.all
    build_base_data_for_one

    build_research_area_by ra_id unless ra_id.blank?
    build_publication_by query unless query.blank?
  end

  def two
    build_base_data_for_two

    patent_id = params[:patent_id]
    get_selected_from_patent(patent_id) unless patent_id.blank?
  end

  private

  def build_base_data_for_one
    @departments = []
    @researchers = []
    @venues = []
    @research_areas = []
    @publications = []
    @grants = []
    @patents = []
  end

  def build_base_data_for_two
    @departments = Department.all
    @researchers = Researcher.all
    @venues = Venue.all
    @research_areas = ResearchArea.all
    @publications = Publication.all
    @grants = Grant.all
    @patents = Patent.all
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

  def get_selected_from_patent(id)
    @patent = Patent.find_by_id(id)

    @selected_patents = Patent.find([ id ])
    @patents = @patents - @selected_patents

    @selected_research_areas = @patent.research_areas
    @research_areas = @research_areas - @selected_research_areas

    @selected_publications = @patent.publications.group(:id)
    @publications = @publications - @selected_publications

    @selected_grants = @patent.grants.group(:id)
    @grants = @grants - @selected_grants

    @selected_researchers = @patent.researchers.group(:id)
    @researchers = @researchers - @selected_researchers

    @selected_venues = @patent.venues.group(:id)
    @venues = @venues - @selected_venues

    @selected_departments = @patent.departments.group(:id)
    @departments = @departments - @selected_departments
  end
end
