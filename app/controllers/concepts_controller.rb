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

  def three
    @research_areas_options = ResearchArea.all
    @related_nodes = []
    ra_id = params[:research_area_id]
    return if ra_id.blank?

    research_area = ResearchArea.find_by_id ra_id
    @selected_node = build_node_for research_area

    related_ras = research_area.research_areas.group(:id)
    related_ras.each do |ra|
      @related_nodes.push(build_node_for(ra)) unless ra.id == ra_id.to_i
    end
  end

  def four
    @research_areas_options = ResearchArea.all
    @nodes = []
    ResearchArea.all.each do |ra|
      @nodes.push(build_node_for(ra))
    end
  end

  def c4_research_area
    ra_id = params[:id]
    @research_area = ResearchArea.find_by_id(ra_id)
    build_base_for_research_area(@research_area)

    publication_id = params[:publication_id]
    c4_get_selected_from_publication(publication_id, @research_area) unless publication_id.blank?

    researcher_id = params[:researcher_id]
    c4_get_selected_from_researcher(researcher_id, @research_area) unless researcher_id.blank?

    department_id = params[:department_id]
    c4_get_selected_from_department(department_id, @research_area) unless department_id.blank?

    venue_id = params[:venue_id]
    c4_get_selected_from_venue(venue_id, @research_area) unless venue_id.blank?

    patent_id = params[:patent_id]
    c4_get_selected_from_patent(patent_id, @research_area) unless patent_id.blank?

    grant_id = params[:grant_id]
    c4_get_selected_from_grant(grant_id, @research_area) unless grant_id.blank?

    reject_from(@selected_publications, @research_area.publications)
    reject_from(@publications, @research_area.publications)

    reject_from(@selected_researchers, @research_area.researchers)
    reject_from(@researchers, @research_area.researchers)

    reject_from(@selected_departments, @research_area.departments)
    reject_from(@departments, @research_area.departments)

    reject_from(@selected_venues, @research_area.venues)
    reject_from(@venues, @research_area.venues)

    reject_from(@selected_grants, @research_area.grants)
    reject_from(@grants, @research_area.grants)

    reject_from(@selected_patents, @research_area.patents)
    reject_from(@patents, @research_area.patents)

    render :partial => "research_area", :locals => {}, :layout => false
  end

  private

  def reject_from(collection, master_collection)
    collection.reject! { |master_item| master_collection.none? { |child_item| child_item.id == master_item.id } }
  end

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

  def build_node_for(research_area)
    Node.create_from(research_area)
  end

  # Concept 4: detail inter-related updating
  def build_base_for_research_area(research_area)
    @publications = research_area.publications.group(:id)
    @researchers = research_area.researchers.group(:id)
    @grants = research_area.grants.group(:id)
    @patents = research_area.patents.group(:id)
    @departments = research_area.departments.group(:id)
    @venues = research_area.venues.group(:id)

    @selected_departments = []
    @selected_researchers = []
    @selected_venues = []
    @selected_publications = []
    @selected_grants = []
    @selected_patents = []
  end

  def c4_get_selected_from_publication(id, ra)
    model = ra.publications.find { |m| m.id == id.to_i }

    @selected_publications = [ model ]
    @publications = @publications - @selected_publications

    @selected_researchers = model.researchers
    @researchers = @researchers - @selected_researchers

    @selected_venues = [ model.venue ]
    @venues = @venues - @selected_venues

    @selected_departments = model.departments.group(:id)
    @departments = @departments - @selected_departments

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants
  end

  def c4_get_selected_from_researcher(id, ra)
    model = ra.researchers.find { |m| m.id == id.to_i }

    @selected_researchers = [ model ]
    @researchers = @researchers - @selected_researchers

    @selected_departments = [ model.department ]
    @departments = @departments - @selected_departments

    @selected_publications = model.publications
    @publications = @publications - @selected_publications

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants

    @selected_venues = model.venues.group(:id)
    @venues = @venues - @selected_venues
  end

  def c4_get_selected_from_department(id, ra)
    model = ra.departments.find { |m| m.id == id.to_i }

    @selected_departments = [ model ]
    @departments = @departments - @selected_departments

    @selected_researchers = model.researchers
    @researchers = @researchers - @selected_researchers

    @selected_publications = model.publications.group(:id)
    @publications = @publications - @selected_publications

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants

    @selected_venues = model.venues.group(:id)
    @venues = @venues - @selected_venues
  end

  def c4_get_selected_from_venue(id, ra)
    model = ra.venues.find { |m| m.id == id.to_i }

    @selected_venues = [ model ]
    @venues = @venues - @selected_venues

    @selected_publications = model.publications
    @publications = @publications - @selected_publications

    @selected_patents = model.patents.group(:id)
    @patents = @patents - @selected_patents

    @selected_researchers = model.researchers.group(:id)
    @researchers = @researchers - @selected_researchers

    @selected_grants = model.grants.group(:id)
    @grants = @grants - @selected_grants

    @selected_departments = model.departments.group(:id)
    @departments = @departments - @selected_departments
  end

  def c4_get_selected_from_grant(id, ra)
    model = ra.grants.find { |m| m.id == id.to_i }

    @selected_grants = [ model ]
    @grants = @grants - @selected_grants

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

  def c4_get_selected_from_patent(id, ra)
    model = ra.patents.find { |m| m.id == id.to_i }

    @selected_patents = [ model ]
    @patents = @patents - @selected_patents

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

class Node
  attr_accessor :research_area
  attr_accessor :id, :title
  attr_accessor :publications_related_count, :publications_max_count
  attr_accessor :researchers_related_count, :researchers_max_count
  attr_accessor :venues_related_count, :venues_max_count
  attr_accessor :departments_related_count, :departments_max_count
  attr_accessor :grants_related_count, :grants_max_count
  attr_accessor :patents_related_count, :patents_max_count

  def self.create_from(research_area)
    node = Node.new
    node.research_area = research_area
    node.id = research_area.id
    node.title = research_area.name

    node.publications_related_count = research_area.publications.group(:id).length
    node.publications_max_count = Publication.all.length

    node.researchers_related_count = research_area.researchers.group(:id).length
    node.researchers_max_count = Researcher.all.length

    node.venues_related_count = research_area.venues.group(:id).length
    node.venues_max_count = Venue.all.length

    node.departments_related_count = research_area.departments.group(:id).length
    node.departments_max_count = Department.all.length

    node.grants_related_count = research_area.grants.group(:id).length
    node.grants_max_count = Grant.all.length

    node.patents_related_count = research_area.patents.group(:id).length
    node.patents_max_count = Patent.all.length

    node
  end
end

