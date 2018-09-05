json.array!(@claims) do |claim|
  json.extract! claim, :id, :claim_id, :claimant_name, :postcode, :policy_no
  json.url claim_url(claim, format: :json)
end
