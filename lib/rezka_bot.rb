# frozen_string_literal: true

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
  end

  def login(username, password)
    visit('/')
    click_on('Вход')

    fill_in('login_name', with: username)
    fill_in('login_password', with: password)

    click_on('Войти')
  end

  def get_movie_titles_and_genres
    visit('/')
    page_number = 1
    max_pages = 1

    movies_data = []

    loop do
      movie_blocks = all('.b-content__inline_item-link')

      movie_blocks.each do |movie_block|
        title = movie_block.find('a').text
        genre = movie_block.find('div:last-child').text

        movies_data << { title: title, genre: genre }
      end

      break if page_number >= max_pages # Зупиняємо цикл після досягнення максимальної кількості сторінок

      next_page_links = all('.b-navigation__item a').map { |link| link[:href] }
      break unless next_page_links

      next_page_links.first&.click
      page_number += 1
    end

    movies_data # Повернути зібрані дані про фільми
  end

  def save_movies_to_file_each_35_movies(movies_data)
    file_counter = 1
    directory_name = 'data'

    FileUtils.mkdir_p(directory_name)

    movies_data.each_slice(35) do |movies_slice|
      file_name = "#{directory_name}/movies_#{file_counter}.txt"

      File.open(file_name, 'w') do |file|
        movies_slice.each do |movie|
          title = movie[:title]
          genre = movie[:genre]
          file.puts "Назва фільму: #{title}, Жанр: #{genre}"
        end
      end

      file_counter += 1
    end
  end
end
