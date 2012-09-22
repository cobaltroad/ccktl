class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :slug
      t.hstore :data
      t.tsvector :vector

      t.timestamps
    end
  end
end
