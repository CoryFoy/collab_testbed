class AddResearchAreaMappings < ActiveRecord::Migration
  def up
    create_table :publications_research_areas, :id => false do |t|
      t.references :publication
      t.references :research_area
    end
    create_table :patents_research_areas, :id => false do |t|
      t.references :patent
      t.references :research_area
    end
    create_table :grants_research_areas, :id => false do |t|
      t.references :grant
      t.references :research_area
    end
  end

  def down
  end
end
