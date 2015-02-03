class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.date   :release_date
      t.string :name
      t.text   :description
      t.timestamps
    end
  end
end
