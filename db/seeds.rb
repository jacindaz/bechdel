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

User.create!(username: 'Jacinda', password: 'Jacinda', avatar_url: 'avatars2.githubusercontent.com/u/6325129?s=460',
              provider: 'Github', location: 'Cambridge', email: 'jacindaz@gmail.com')

# movies = [
#   { title: "Maleficent", year: 2014, summary: "Maleficent explores the untold story of Disney's most iconic villain from the classic 'Sleeping Beauty' and the elements of her betrayal that ultimately turn her pure heart to stone. Driven by revenge and a fierce desire to protect the moors over which she presides, Maleficent cruelly places an irrevocable curse upon the human king's newborn infant Aurora. As the child grows, Aurora is caught in the middle of the seething conflict between the forest kingdom she has grown to love and the human kingdom that holds her legacy. Maleficent realizes that Aurora may hold the key to peace in the land and is forced to take drastic actions that will change both worlds forever.",
#     language: "English", country_produced: "USA", bechdel_rating: "pass", poster_url: "http://content8.flixster.com/rtmovie/11/80/118050_gal.jpg",
#     rotten_tomatoes_rating: "5.6", movie_url: 'http://www.rottentomatoes.com/m/maleficent_2014/',
#     user_id: 1}
# ]

Movie.create!(title: "Maleficent", year: 2014, summary: "Maleficent explores the untold story of Disney's most iconic villain from the classic 'Sleeping Beauty' and the elements of her betrayal that ultimately turn her pure heart to stone. Driven by revenge and a fierce desire to protect the moors over which she presides, Maleficent cruelly places an irrevocable curse upon the human king's newborn infant Aurora. As the child grows, Aurora is caught in the middle of the seething conflict between the forest kingdom she has grown to love and the human kingdom that holds her legacy. Maleficent realizes that Aurora may hold the key to peace in the land and is forced to take drastic actions that will change both worlds forever.",
    language: "English", country_produced: "USA", bechdel_rating: "pass", poster_url: "http://content8.flixster.com/rtmovie/11/80/118050_gal.jpg",
    rotten_tomatoes_rating: "5.6", movie_url: 'http://www.rottentomatoes.com/m/maleficent_2014/',
    user_id: 1)
