namespace :email do

  desc "Goes through the email body content and extracts "
  task :extract_subjects => [:environment] do |t, args|
    p "in email:extract_subjects"

    p Claim.first
  end

end
