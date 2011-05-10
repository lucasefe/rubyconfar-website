require 'data_mapper'

class Registration
  include DataMapper::Resource

  property :id,           Serial
  property :email,        String, :required => true, :unique => true, :format => :email_address
  property :created_at,   DateTime

end
