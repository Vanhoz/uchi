class CreateContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :contributors do |t|
      t.string :name
      t.integer :quantity
      t.integer :place
      t.belongs_to :repository, foreign_key: true, null: false

      t.timestamps
    end
  end
end
