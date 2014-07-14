# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  # create_table "movies", force: true do |t|
  #   t.string   "title",                                        null: false
  #   t.integer  "year",                                         null: false
  #   t.text     "summary",                                      null: false
  #   t.string   "language",                                     null: false
  #   t.string   "country_produced",                             null: false
  #   t.string   "bechdel_rating",         default: "no rating", null: false
  #   t.text     "poster_url",                                   null: false
  #   t.string   "rotten_tomatoes_rating"
  #   t.string   "movie_url",                                    null: false
  #   t.integer  "user_id",                                      null: false
  #   t.integer  "actresses_id",                                 null: false
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

User.delete_all
Movie.delete_all

User.create!(username: 'Jacinda', password: 'Jacinda2014', avatar_url: 'avatars2.githubusercontent.com/u/6325129?s=460',
              provider: 'Github', location: 'Cambridge', email: 'jacindaz@gmail.com')
