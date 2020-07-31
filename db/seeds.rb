SavedPosting.destroy_all
User.destroy_all

# Random User Creation with Random Category to demo our recommendation feature
(1..60).each do |i|
    User.create!(username: Faker::Name.unique.name, password: "testuser#{i}", password_confirmation: "testuser#{i}", category: Category.all.sample)
end

(1..200).each do |i|
    SavedPosting.create(user_id: User.all.sample.id, posting_id: Posting.all.sample.id)
end