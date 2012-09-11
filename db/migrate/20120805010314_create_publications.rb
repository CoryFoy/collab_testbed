class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name
      t.integer :venue_id
      t.datetime :publication_date

      t.timestamps
    end
  end
end
