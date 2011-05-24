require 'data_mapper'

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
  property :speaker_email,    String, :required => true, :format => :email_address
  property :speaker_bio,      Text
  property :created_at,       DateTime

end
