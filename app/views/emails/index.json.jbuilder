json.array!(@emails) do |email|
  json.extract! email, :id, :subject, :body, :from, :to
  json.url email_url(email, format: :json)
end
