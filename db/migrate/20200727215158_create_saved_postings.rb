class CreateSavedPostings < ActiveRecord::Migration[6.0]
  def change
    create_table :saved_postings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :posting, null: false, foreign_key: true
      t.boolean :super_post, default: false

      t.timestamps
    end
  end
end
