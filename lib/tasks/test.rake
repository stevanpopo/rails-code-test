namespace :test do

  desc "test"
  task :test => [:environment] do |t, args|

    # pol_num = Array.new(8){rand(36).to_s(36)}.join.upcase
    # p pol_num

    arr = Array.new(8) # makes an array with 8 elements
    # p arr
    n = rand(36) # makes random number up to 36
    # p n
    num_str = rand(100).to_s
    # p num_str
    arr_num = Array.new(8){rand(36).to_s(36)} # passing arg to to_s changes the base
    # p arr_num

    # Format - NW2 1SN

    letters = Array('A'..'Z')
    p letters
    post_code = Array.new(2){letters.sample}.join.to_s + rand(9).to_s + ' ' + rand(9).to_s + Array.new(2){letters.sample}.join.to_s
    p post_code

  end
end
