class CreatePatents < ActiveRecord::Migration
  def change
    create_table :patents do |t|
      t.string :title

      t.timestamps
    end
  end
end
