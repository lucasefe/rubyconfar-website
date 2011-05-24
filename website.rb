# encoding: utf-8
require "sinatra/base"
require "haml"
require 'sass'
require 'data_mapper'
require "ostruct"

ENV["RACK_ENV"] = "development" unless ENV["RACK_ENV"]
RACK_ENV = ENV["RACK_ENV"]

require File.expand_path(File.join(File.dirname(__FILE__), "lib/models.rb"))

module RubyConf
  class Website < Sinatra::Application
    
    CONFIG = OpenStruct.new(YAML.load(ERB.new(File.read("#{Dir.pwd}/config/settings.yml")).result)[RACK_ENV])
    LANGUAGES = CONFIG.languages
    
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

    set :public, File.expand_path("../public", __FILE__)
    set :haml,   :format => :html5
    set :logging, :true
    enable :sessions

    configure do
      DataMapper::Logger.new($stdout, :debug) if RACK_ENV == "development"
      DataMapper.setup(:default, CONFIG.database)
      DataMapper.auto_upgrade!
    end

    helpers do
      def partial(page, options={})
        haml page, options.merge!(:layout => false)
      end

      def flashes
        [:notice, :warning, :error].each do |key|
          haml_tag(:div, session.delete(key), :class => "flash #{key}") if session.has_key?(key)
        end
      end

      alias flash session
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

    page "proposals" do
      @proposal = Proposal.new
      haml :proposals
    end

    post '/proposals' do
      @proposal = Proposal.new params[:proposal]

      if @proposal.save
        flash[:notice] = "You have successfully sent your proposal!"
        redirect "/"
      else
        haml :proposals
      end
    end

    page "registration" do
      flash[:notice] = "Please, fill the 'Keep me posted' form. "
      redirect "/"
    end
    page "sponsoring" do
      haml :sponsoring
    end

    page "about" do
      haml :about
    end

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

    def twitter(text="Seguinos en twitter", user="RubyConfAr")
      link_to text, "http://twitter.com/#{user}", :class => "twitter", :target => 'blank'
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

      skip_translation = options.delete(:skip_translation)

      if Symbol === template_or_code && !skip_translation
        super(:"#{template_or_code}_#{language}", options, &block)
      else
        super
      end
    end
  end
end
