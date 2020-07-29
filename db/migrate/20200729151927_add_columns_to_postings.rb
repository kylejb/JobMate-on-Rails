class AddColumnsToPostings < ActiveRecord::Migration[6.0]
  def change
    add_column :postings, :link, :string
    add_column :postings, :salary, :string
    add_column :postings, :languages, :string
    add_column :postings, :experience, :string
    add_column :postings, :requirements, :string
  end
end
