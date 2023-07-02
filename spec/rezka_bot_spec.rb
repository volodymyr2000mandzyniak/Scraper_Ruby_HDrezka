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

  let(:rezka_bot) { described_class.new }

  describe '#get_movie_titles_and_genres' do
    it 'displays movie titles and genres' do
      rezka_bot.login('hdrezka_pars', 'C2j85@Pi.zJDnm-')
      movies_data = rezka_bot.get_movie_titles_and_genres

      expect(movies_data).to be_an(Array)
      expect(movies_data.first).to include(:title, :genre)
    end
  end
end

