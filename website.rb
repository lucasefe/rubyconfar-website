# encoding: utf-8
require "bundler/setup"
require "sinatra/base"
require "haml"
require 'sass'
require 'data_mapper'
require 'rack-flash'

require File.expand_path(File.join(File.dirname(__FILE__), "lib/models.rb"))

module RubyConf    
  class Website < Sinatra::Application
    LANGUAGES = { "en" => "English", "es" => "Español" }

    def self.check_language!
      condition { LANGUAGES.keys.include?(params[:lang]) }
    end

    def self.page(path, &block)
      path = "/" + path.gsub(/^\//, '')

      get path do
        redirect "#{language}#{path}"
      end

      get "/:lang#{path}", &block
    end

    use Rack::Flash
    
    set :public, File.expand_path("../public", __FILE__)
    set :haml,   :format => :html5
    set :logging, :true
    enable :sessions

    configure do
      DataMapper::Logger.new($stdout, :debug)  
      DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/development.db")
      DataMapper.auto_upgrade!
    end
    
    helpers do
      def flashes
        [:warning, :notice, :error].each do |key|
          haml_tag(:div, flash[key], :class => "flash #{key}") if flash.has?(key)
        end
      end
    end

    get "/" do
      redirect language
    end

    get '/website.css' do
      sass :website
    end

    check_language!
    get "/:lang" do
      haml :home
    end

    post "/register" do
      @registration = Registration.new params[:registration]
      
      if @registration.save
        flash[:notice] = "You have successfully pre-registered!"
        redirect "/"
      else
        haml :home
      end
    end
    # page "events" do
    #   haml :events
    # end

    def language
      @lang ||= params[:lang] || language_from_http || "en"
    end

    def language_from_http
      env["HTTP_ACCEPT_LANGUAGE"].to_s.split(",").each do |lang|
        %w(en es).each {|code| return code if lang =~ /^#{code}/ }
      end
      nil
    end

    def speaker_twitter(user)
      "Twitter: " + link_to("@#{user}", "http://twitter.com/#{user}")
    end

    def twitter(text="sígannos en twitter", user="rubyconfuruguay")
      link_to text, "http://twitter.com/#{user}", :class => "twitter"
    end

    def email(text="envíennos un email", address="info@rubyconfuruguay.org")
      link_to text, "mailto:#{address}", :class => "email"
    end

    def link_to(text, url=nil, options={}, &block)
      url, text = text, capture_haml(&block) if url.nil?
      capture_haml do
        haml_tag :a, text, options.merge(:href => url)
      end
    end

    def haml(template_or_code, options={}, &block)
      layout = options.has_key?(:layout) ? options.delete(:layout) : :layout
      options[:layout] = :"#{layout}_#{language}" if layout

      skip_translation = options.delete(:skip_transation)

      if Symbol === template_or_code && !skip_translation
        super(:"#{template_or_code}_#{language}", options, &block)
      else
        super
      end
    end
  end
end
