class Claim
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: String, default: 'open'
  field :claim_id, type: String
  field :claimant_name, type: String
  field :postcode, type: String
  field :policy_no, type: String
  field :settlement_amount, type: String
  field :settlement_date, type: String

  has_many :emails
  has_many :notes

  # def self.search(search)
  #   if search
  #     any_of({ :claim_id => "#{search}"}, { :claimant_name => "#{search}"})
  #   end
  # end

  # def self.search(search, page)
  #   paginate :per_page => 5, :page => page,
  #            :conditions => ['name like ?', "%#{search}%"]
  # end
end
