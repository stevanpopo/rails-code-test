namespace :test do

  LETTERS = Array('A'..'Z')

  def make_postcode()
   return Array.new(2){LETTERS.sample}.join.to_s + rand(9).to_s + ' ' + rand(9).to_s + Array.new(2){LETTERS.sample}.join.to_s
  end

  desc "test"
  task :test => [:environment] do |t, args|

    p make_postcode()

  end
end
