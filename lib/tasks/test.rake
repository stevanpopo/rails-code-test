namespace :test do

  SAMPLE_NOTE_BODIES = [
    "I phoned the policyholder and arranged a time to visit.",
    "They complained about bad customer service from the call centre.",
    "After visiting the site I arranged a follow-up visit.",
    "Tried calling the customer all day, but I did not get a response. Will try again next week.",
    "The customer then told me to cancel the appointment because she is going on holiday.",
    "I'm working on my report and will deliver it by the end of this week.",
    "This claim should be cancelled because the customer can not be reached via phone or email.",
    "There was a complaint about workmen walking through the PH's house with dirty boots.",
    "I advised the customer that we are dealing with his claims as quickly as possible.",
    "The customer also phoned in to amend her address details because she has moved house."
   ]

  desc "test"
  task :test => [:environment] do |t, args|

    p 'did this run'

    # Note.only(:claim_id, :id).limit(rand(10)).only.each do |e|
    # 	p e
    # end

    # Email.only(:claim_id, :id).limit(5).only.each do |e|
    #  	e.set(claim_id: claim_ids.sample)
    # end

    # p Email.only(:claim_id) limites fields returned

    # p Email.only(:claim_id, :id, :made_up)

    # claim_ids = Claim.all.collect(&:id)
    # p claim_ids
    #
    # Email.only(:claim_id, :id).limit(5).each do |e|
    #   p 'what is this' + e
    # end

    claim_ids = [123, 234, 456]

    claim_ids.each do |id|
      rand(10).times do |i|

        p id, i
      end
    end

  end
end
