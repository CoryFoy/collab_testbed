class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.string :name
      t.integer :department_id

      t.timestamps
    end
  end
end
