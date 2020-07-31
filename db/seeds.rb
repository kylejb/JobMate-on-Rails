User.destroy_all

# Random User Creation with Random Category to demo our recommendation feature
(1..60).each do |i|
    User.create!(username: Faker::Name.unique.name, password: "testuser#{i}", password_confirmation: "testuser#{i}", category: Category.all.sample)
end

(1..200).each do |i|
    SavedPosting.create!(user: User.all.sample, posting: Posting.all.sample)
end