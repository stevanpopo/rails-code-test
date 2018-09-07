class Claim
  include Mongoid::Document 
  include Mongoid::Timestamps

  field :claim_id, type: String
  field :claimant_name, type: String
  field :postcode, type: String
  field :policy_no, type: String

  has_many :emails
end