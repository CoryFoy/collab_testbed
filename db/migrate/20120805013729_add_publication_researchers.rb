class AddPublicationResearchers < ActiveRecord::Migration
  def up
    create_table :publications_researchers, :id => false do |t|
      t.references :publication
      t.references :researcher
    end
  end

  def down
    drop_table :publications_researchers
  end
end
