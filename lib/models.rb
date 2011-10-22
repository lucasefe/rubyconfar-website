require 'data_mapper'
require 'yaml_record'
require "pony"

class Speaker < YamlRecord::Base
  properties :name, :picture, :company, :twitter,
    :description_en, :description_es, :links, :talk

  source File.join(File.dirname(__FILE__), "../db/speakers")
end


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


  after :save, :send_notifications

  private

  def send_notifications
    notify_speaker
    notify_organizers
  end

  def notify_speaker
    Pony.mail :to => speaker_email,
              :subject => "Your proposal for RubyConf Argentina 2011 has been received!",
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
              :body => <<EOM
Thank you #{speaker_name}!

Your "#{title}" proposal has been received. We would also like to
remind you that the Call for Papers will end on July 31st, so feel
free to submit another entry if you like to and of course invite your
friends! After that date we will inform you and the community when
will the results be published.

Hoping to see you in Buenos Aires,

The RubyConf Argentina Team.
@RubyConfAr
http://rubyconfargentina.org/en
EOM

  end

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
