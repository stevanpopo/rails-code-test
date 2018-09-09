namespace :test do

  LETTERS = Array('A'..'Z')

  def rand_letters(number)
    return Array.new(number){LETTERS.sample}.join.to_s
  end

  def make_postcode()
   return rand_letters(2) + rand(9).to_s + ' ' + rand(9).to_s + rand_letters(2)
  end

  desc "test"
  task :test => [:environment] do |t, args|

    p make_postcode()

  end
end
