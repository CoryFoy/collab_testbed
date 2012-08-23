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

    research_area_id = params[:research_area_id]
    get_selected_from_research_area(research_area_id) unless research_area_id.blank?

    publication_id = params[:publication_id]
    get_selected_from_publication(publication_id) unless publication_id.blank?

    researcher_id = params[:researcher_id]
    get_selected_from_researcher(researcher_id) unless researcher_id.blank?

    department_id = params[:department_id]
    get_selected_from_department(department_id) unless department_id.blank?

    venue_id = params[:venue_id]
    get_selected_from_venue(venue_id) unless venue_id.blank?

    patent_id = params[:patent_id]
    get_selected_from_patent(patent_id) unless patent_id.blank?

    grant_id = params[:grant_id]
    get_selected_from_grant(grant_id) unless grant_id.blank?
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

    @selected_departments = []
    @selected_researchers = []
    @selected_venues = []
    @selected_research_areas = []
    @selected_publications = []
    @selected_grants = []
    @selected_patents = []
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

  def get_selected_from_research_area(id)
    model = ResearchArea.find_by_id(id)

    @selected_research_areas = ResearchArea.find([ id ])
    @research_areas = @research_areas - @selected_research_areas

    @selected_patents = model.patents
    @patents = @patents - @selected_patents

    @selected_grants = model.grants
    @grants = @grants - @selected_grants

    @selected_researchers = model.researchers.group(:id)
    @researchers = @researchers - @selected_researchers

    @selected_publications = model.publications.group(:id)
    @publications = @publications - @selected_publications

    @selected_venues = model.venues.group(:id)
    @venues = @venues - @selected_venues

    @selected_departments = model.departments.group(:id)
    @departments = @departments - @selected_departments

  end

  def get_selected_from_publication(id)
    model = Publication.find_by_id(id)

    @selected_publications = Publication.find([ id ])
    @publications = @publications - @selected_publications

    @selected_researchers = model.researchers
    @researchers = @researchers - @selected_researchers

    @selected_research_areas = model.research_areas.group(:id)
    @research_areas = @research_areas - @selected_research_areas

    @selected_venues = [ model.venue ]
    @venues = @venues - @selected_venues

    @selected_departments = model.departments.group(:id)
    @departments = @departments - @selected_departments

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants
  end

  def get_selected_from_researcher(id)
    model = Researcher.find_by_id(id)

    @selected_researchers = Researcher.find([ id ])
    @researchers = @researchers - @selected_researchers

    @selected_departments = [ model.department ]
    @departments = @departments - @selected_departments

    @selected_publications = model.publications
    @publications = @publications - @selected_publications

    @selected_research_areas = model.research_areas.group(:id)
    @research_areas = @research_areas - @selected_research_areas

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants

    @selected_venues = model.venues.group(:id)
    @venues = @venues - @selected_venues
  end

  def get_selected_from_department(id)
    model = Department.find_by_id(id)

    @selected_departments = Department.find([ id ])
    @departments = @departments - @selected_departments

    @selected_researchers = model.researchers
    @researchers = @researchers - @selected_researchers

    @selected_publications = model.publications.group(:id)
    @publications = @publications - @selected_publications

    @selected_research_areas = model.research_areas.group(:id)
    @research_areas = @research_areas - @selected_research_areas

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants

    @selected_venues = model.venues.group(:id)
    @venues = @venues - @selected_venues
  end

  def get_selected_from_venue(id)
    model = Venue.find_by_id(id)

    @selected_venues = Venue.find([ id ])
    @venues = @venues - @selected_venues

    @selected_publications = model.publications
    @publications = @publications - @selected_publications

    @selected_research_areas = model.research_areas.group(:id)
    @research_areas = @research_areas - @selected_research_areas

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_researchers = model.researchers.group(:id)
    @researchers = @researchers - @selected_researchers

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants

    @selected_departments = model.departments.group(:id)
    @departments = @departments - @selected_departments
  end

  def get_selected_from_grant(id)
    model = Grant.find_by_id(id)

    @selected_grants = Grant.find([ id ])
    @grants = @grants - @selected_grants

    @selected_research_areas = model.research_areas
    @research_areas = @research_areas - @selected_research_areas

    @selected_publications = model.publications.group(:id)
    @publications = @publications - @selected_publications

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_researchers = model.researchers.group(:id)
    @researchers = @researchers - @selected_researchers

    @selected_venues = model.venues.group(:id)
    @venues = @venues - @selected_venues

    @selected_departments = model.departments.group(:id)
    @departments = @departments - @selected_departments
  end

  def get_selected_from_patent(id)
    model = Patent.find_by_id(id)

    @selected_patents = Patent.find([ id ])
    @patents = @patents - @selected_patents

    @selected_research_areas = model.research_areas
    @research_areas = @research_areas - @selected_research_areas

    @selected_publications = model.publications.group(:id)
    @publications = @publications - @selected_publications

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants

    @selected_researchers = model.researchers.group(:id)
    @researchers = @researchers - @selected_researchers

    @selected_venues = model.venues.group(:id)
    @venues = @venues - @selected_venues

    @selected_departments = model.departments.group(:id)
    @departments = @departments - @selected_departments
  end
end
