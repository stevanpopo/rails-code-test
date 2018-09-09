class Claim
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: String, default: 'open'
  field :claim_id, type: String
  field :claimant_name, type: String
  field :postcode, type: String
  field :policy_no, type: String
  field :settlement_amount, type: String
  field :settlement_date, type: DateTime

  has_many :emails
  has_many :notes
end
