# encoding: utf-8
require "sinatra/base"
require 'sinatra/cache'
require 'date'
require 'haml'
require 'sass'
require 'ostruct'
require 'haml-coderay'


ENV["RACK_ENV"] = "development" unless ENV["RACK_ENV"]
RACK_ENV = ENV["RACK_ENV"]

%w(speaker talk).each do |model|
  require File.expand_path(File.join(File.dirname(__FILE__), "lib/#{model}.rb"))
end

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

    set :root, Dir.pwd
    set :public, File.expand_path("../public", __FILE__)
    set :haml,   :format => :html5
    set :logging, :true
    enable :sessions
    register(Sinatra::Cache)
    set :cache_enabled, true
    
    # configure do
    #   DataMapper::Logger.new($stdout, :debug) if RACK_ENV == "development"
    #   DataMapper.setup(:default, CONFIG.database)
    #   DataMapper.auto_upgrade!
    # end

    helpers do
      
      def full_price?
        DateTime.now >= DateTime.parse("2011/10/1 0:0:0")
      end
      
      def partial(page, options={})
        haml page, options.merge!(:layout => false)
      end

      def flashes
        [:notice, :warning, :error].each do |key|
          haml_tag(:div, session.delete(key), :class => "flash #{key}") if session.has_key?(key)
        end
      end
      def simple_format(text)
        return "" if text.nil?
        "<p>#{text.gsub("\n", "</p><p>")}</p>"
      end
      alias flash session
    end

    get "/" do
      redirect language
    end

    get '/website.css' do
      sass :website
    end
    
    get "/drinkups" do
      haml :drinkups, :skip_translation => true
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

    page "/rubyfunday" do
      haml :rubyfunday
    end

    page "/agenda" do
      haml :agenda
    end

    page "registration" do
      flash[:notice] = "Please, fill the 'Keep me posted' form. "
      redirect "/"
    end
    
    page "speakers" do
      haml :speakers
    end

    page "sponsoring" do
      haml :sponsoring
    end

    page "event" do
      haml :event
    end

    def language
      @lang ||= params[:lang] || language_from_http || "en"
    end

    def current_path(options = {})
      request.url.gsub(/\/(#{language})/, "/#{options.fetch(:lang, language)}")
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

    def active_link?(route)
      request.route == route
    end

    def link_to(text, url=nil, options={}, &block)
      url, text = text, capture_haml(&block) if url.nil?
      options.merge!(:class => 'active') if active_link?(url)
      capture_haml do
        haml_tag :a, text, options.merge(:href => url)
      end
    end

    def pluralize(count, singular, plural = nil)
      "#{count || 0} " + ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
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
