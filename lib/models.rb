require 'data_mapper'
require "pony"

class Registration
  include DataMapper::Resource

  property :id,           Serial
  property :email,        String, :required => true, :unique => true, :format => :email_address
  property :created_at,   DateTime

end

class Proposal
  include DataMapper::Resource

  property :id,               Serial
  property :title,            String, :required => true
  property :description,      Text, :required => true
  property :speaker_name,     String, :required => true
  property :speaker_email,    String, :required => true, :format => :email_address, :unique => false
  property :speaker_bio,      Text
  property :created_at,       DateTime


  after :save, :notify_organizers

  private

  def notify_organizers
    Pony.mail :to => RubyConf::Website::CONFIG.email_recipients,
              :subject => "New Proposal from #{speaker_name} about #{title}",
              :enable_starttls_auto => true,
              :via => :smtp,
              :via_options => {
                :address              => 'smtp.gmail.com',
                :port                 => '587',
                :enable_starttls_auto => true,
                :user_name            => RubyConf::Website::CONFIG.smtp_settings['user_name'],
                :password             => RubyConf::Website::CONFIG.smtp_settings['password'],
                :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
              },
              :body => self.attributes.map {|k, v| "#{k}: #{v}\n" }.join("\n")

  end
end
