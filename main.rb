# frozen_string_literal: true

require_relative 'lib/rezka_bot'

bot = RezkaBot.new
bot.login('hdrezka_pars', 'C2j85@Pi.zJDnm-')
bot.get_movie_titles_and_genres
