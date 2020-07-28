class CreateFavoriteCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_companies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
