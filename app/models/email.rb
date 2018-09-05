class Email
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subject, type: String
  field :body, type: String
  field :from, type: String
  field :to, type: String

  belongs_to :claim
end
