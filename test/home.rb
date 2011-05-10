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
end
