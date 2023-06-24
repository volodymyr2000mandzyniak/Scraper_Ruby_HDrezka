# frozen_string_literal: true

require_relative '../lib/rezka_bot'
require 'capybara/rspec'

RSpec.describe RezkaBot do
  include Capybara::DSL

  before(:all) do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end

    Capybara.default_driver = :selenium
    Capybara.app_host = 'https://rezka.ag'
  end

  after(:all) do
    Capybara.current_session.driver.quit
  end

  let(:rezka_bot) { RezkaBot.new }

  describe 'login' do
    it 'check_login' do
      expect(RezkaBot.new.login('hdrezka_pars',
                                'C2j85@Pi.zJDnm-')).to eq(login_name: 'hdrezka_pars', login_password: 'C2j85@Pi.zJDnm-')
    end
  end

  describe '#get_movie_titles_and_genres' do
    it 'displays movie titles and genres' do
      # rezka_bot.login('hdrezka_pars', 'C2j85@Pi.zJDnm-')
      rezka_bot.get_movie_titles_and_genres

      expect(page).to have_content('All movies')
    end
  end
end
