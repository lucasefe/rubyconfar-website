require "fileutils"

# Make sure we are running in the test environment.
ENV["RACK_ENV"] = "test"

# Remove test database.
FileUtils.rm_f(File.expand_path(File.join(File.dirname(__FILE__), "..", "db", "test.db")))

# Require web app.
require File.expand_path(File.join(File.dirname(__FILE__), "..", "website.rb"))

require "capybara/dsl"
require "cutest"

class Cutest::Scope
  include Capybara
end

Capybara.app = RubyConf::Website

scope do
  test do
    visit "/en"

    assert has_content?("The largest event in the Ruby Community in the Spanish speaking world.")
    fill_in "registration[email]", :with => "albert@test.com"
    click_button "OK"

    assert has_content?("You have successfully pre-registered!")
  end
  
  test "en#navigation" do
    visit "/en"

    within "#navigation" do
      assert has_content?("Home")
      assert has_content?("Call for papers")
      assert has_content?("Sponsoring")
      assert has_content?("Speakers")
      assert has_content?("About")
    end
  end

  test "(en) successful submit of proposal" do
    visit "/en/proposals"
    within("#proposals") { assert has_content?("Call For Papers") }
    fill_in "proposal[title]", :with => "fun on conferences"
    fill_in "proposal[description]", :with => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    fill_in "proposal[speaker_name]", :with => "Aaron Patterson"
    fill_in "proposal[speaker_email]", :with => "tender@love.com"
    fill_in "proposal[speaker_bio]", :with => "rails core, ruby core... etc. "
    click_button "Submit Proposal"
    assert has_content?("You have successfully sent your proposal!")

    assert_equal Proposal.last.title, "fun on conferences"
  end

  test "en/sponsoring" do
    visit "/en/sponsoring"
    within("#sponsoring") do 
      assert has_content?("Sponsoring") 
      assert has_content?("Platinum")
      assert has_content?("Gold")
      assert has_content?("Silver")
      assert has_content?("Bronze")
    end
  end

  test "en/about" do
    visit "/en/about"
    within("#about") { assert has_content?("About who we are") }
  end

  test "es#navigation" do
    visit "/es"

    within "#navigation" do
      assert has_content?("Inicio")
      assert has_content?("Convocatoria")
      assert has_content?("Sponsoreo")
      assert has_content?("Oradores")
      assert has_content?("Acerca")
    end
  end

  test "es/proposals" do
    visit "/es/proposals"
    within("#content") { assert has_content?("Convocatoria") }
  end
  
  test "es/about" do
    visit "/es/about"
    within("#about") { assert has_content?("Quienes somos") }
  end

  test "es/sponsoring" do
    visit "/es/sponsoring"
    within("#content") do 
      assert has_content?("Sponsoreo") 
      assert has_content?("Platinum")
      assert has_content?("Gold")
      assert has_content?("Silver")
      assert has_content?("Bronze")
    end
  end
end
