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
    visit "/"

    assert has_content?("Welcome")

    fill_in "registration[email]", with: "albert@test.com"
    click_button "Register me!"

    assert has_content?("You have successfully pre-registered!")
  end
  
  test "en#navigation" do
    visit "/en"

    within "#navigation" do
      assert has_content?("Home")
      assert has_content?("Call for papers")
      assert has_content?("Sponsoring")
      assert has_content?("Registration")
      assert has_content?("About")
    end
  end

  test "en/call-for-papers" do
    visit "/en/call-for-papers"
    within("#content") { assert has_content?("Call For Papers") }
  end

  test "es#navigation" do
    visit "/es"

    within "#navigation" do
      assert has_content?("Inicio")
      assert has_content?("Convocatoria De Presentaciones")
      assert has_content?("Sponsoring")
      assert has_content?("Registracion")
      assert has_content?("Acerca")
    end
  end

  test "es/call-for-papers" do
    visit "/es/call-for-papers"
    within("#content") { assert has_content?("Convocatoria De Presentaciones") }
  end
end
