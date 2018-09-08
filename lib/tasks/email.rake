namespace :email do

  desc "Goes through the email body content and extracts "
  task :extract_subjects => [:environment] do |t, args|
    p "in email:extract_subjects"
    # p Email.first

    # emails = Email.find{(58ba8f2facce343bdc000053})
    email = Email.find_by(_id: "58ba8f2facce343bdc000053")

    # p emails

    # emails.each do |email|
    #   puts email.body
    # end

    hi = "Hello Stevan good to see you"
    p hi[2, 5]

    # p email.body
    if email.body.include? 'Subject'
      p 'has subject'
      # strip = email.body.strip
      # p strip
      return_index = email.body.index(/\r\n\r\n/)
      subject_index = email.body.index('Subject')
      length = return_index - subject_index
      p length
      p email.body.slice(subject_index, length)

    end
  end

end
