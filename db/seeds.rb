# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.first.achievements.create([
                                 { title: 'Heidi’s Apprentice', description: 'Complete your first flashcard deck' },
                                 { title: 'Swiss Timekeeper', description: 'Maintain a streak for 3 days' },
                                 { title: 'Swiss Army Knife', description: 'Create your own custom flashcard deck' }
                               ])
