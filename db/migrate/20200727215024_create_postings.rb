class CreatePostings < ActiveRecord::Migration[6.0]
  def change
    create_table :postings do |t|
      t.string :title
      t.string :description
      t.datetime :posting_date
      t.string :location
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
