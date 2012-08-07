class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.string :title
      t.decimal :amount
      t.date :date_awarded

      t.timestamps
    end
  end
end
