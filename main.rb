# frozen_string_literal: true

require_relative 'lib/rezka_bot'

bot = RezkaBot.new
bot.login('hdrezka_pars', 'C2j85@Pi.zJDnm-')
movies_data = bot.get_movie_titles_and_genres
bot.save_movies_to_file_each_35_movies(movies_data)
