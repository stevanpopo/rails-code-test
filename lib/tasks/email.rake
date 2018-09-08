namespace :email do

  desc "Goes through the email body content and extracts "
  task :extract_subjects => [:environment] do |t, args|

    emails = Email.all

    emails.each do |email|
      if email.body
        if email.body.include? 'Subject'
          # p 'has subject'
          # p email.body
          subject_index = email.body.index('Subject')
          return_index = email.body.index(/\r\n\r\n/, subject_index)
          # p return_index, subject_index
          length = return_index.to_i - subject_index.to_i

          email.subject = email.body[subject_index, length]
          # p email.subject
        else
          email.subject = email.body[0, 50]
          # p email.subject
        end
      else
        # p 'no email body'
        email.subject = 'N/A'
        # p email.subject
      end
    end

    # p Email.where(subject: nil).count
  end
end
