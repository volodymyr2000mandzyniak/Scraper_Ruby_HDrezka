require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.default_driver = :selenium
Capybara.app_host = 'https://rezka.ag'

class RezkaBot
  include Capybara::DSL

  def initialize
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end

    @wait_time = 10
  end

  def login(username, password)
    visit('/')
    click_on("Вход")

    fill_in('login_name', with: username)
    fill_in('login_password', with: password)

    click_on('Войти')
    puts "Успішно ввійшли!\n======================================="
  end

  def get_movie_titles_and_genres
    visit('/')
    puts "All movies"
    page_number = 1

    loop do
      puts "Page #{page_number}"

      movie_blocks = all('.b-content__inline_item-link')

      movie_blocks.each do |movie_block|
        title = movie_block.find('a').text
        genre = movie_block.find('div:last-child').text
        puts "Назва фільму: #{title}, Жанр: #{genre}"
      end

      next_page_links = all('.b-navigation__item a').map { |link| link[:href] }
      break unless next_page_links

      next_page_links.first&.click
      page_number += 1

      # Дочекатися завантаження нової сторінки
      sleep 5
    end
  end
end

bot = RezkaBot.new
bot.login('hdrezka_pars', 'C2j85@Pi.zJDnm-')
bot.get_movie_titles_and_genres

#=======================НОРМ=======================================


