# =============================================================================================
# CONFIG
# =============================================================================================

# Get the DB details
mongo_config = YAML::load(File.open("#{Rails.root}/config/mongoid.yml"))
production_db_name = mongo_config["production"]["sessions"]["default"]["database"]
development_db_name = mongo_config["development"]["sessions"]["default"]["database"]

# The number of Claims to create
CLAIMS_COUNT = 30

# The average number of emails to assign per claim
EMAILS_PER_CLAIM_COUNT = 100

# =============================================================================================
# 1. IMPORT EMAILS
# =============================================================================================

puts "======================================"
puts "1. Importing emails"
puts "======================================"

# Restore from the recent dump
`mongorestore -d #{development_db_name} #{Rails.root}/tmp/datadump/#{production_db_name}/`

# Recreate indices
Rake::Task["db:mongoid:create_indexes"].execute

# =============================================================================================
# 2. CREATE CLAIMS
#
# Build some claims and associate a sample of emails to each.
#
# =============================================================================================

puts "\n\r======================================"
puts "2. Creating claims"
puts "======================================"

# Define some sample data sets
FIRST_NAMES = ["Samantha", "Lillian", "Savannah", "Jayden", "Mackenzie", "Elise", "Evan", "Hunter", "Cooper", "William", "Lily", "Julia", "Colin", "Jasmine", "Abby", "Isaac", "Caroline", "Jordyn", "Keira", "Harper", "Bryce", "Nathaniel", "Evelyn", "Brooke", "Micah", "Ryan", "Makayla", "Sarah", "Cristina", "Hannah", "Ian", "Ellie", "Mason", "Sebastian", "Kate", "Reagan", "Kennedy", "Nora", "Piper", "Logan", "Alexander", "Amelia", "Gianna", "Bryson", "Madison", "Layla", "Jacob", "Brooklyn", "Liliana", "Kaitlyn", "Daniel", "Hudson", "Levi", "Adrian", "Nolan", "Maya", "Alexa", "Caleb", "Xavier", "Alex", "Oliver", "Madelyn", "Lucas", "Eli", "Katherine", "Taylor", "Jocelyn", "Parker", "Ella", "Julian", "Max", "Allison", "Gabriel", "Brody", "Abigail", "Jordan", "Christopher", "Audrey", "Nevaeh", "Justin", "Stella", "Nathan", "Aria", "Henry", "Joshua", "Cole", "Claire", "Owen", "Sophie", "Hailey", "Luke", "Josiah", "Jonathan", "Aaliyah", "Aiden", "Joseph", "Landon", "Aaron", "Kaylee", "Victoria", "Bella", "Leah", "Mia", "Natalie", "Michael", "Grayson", "Sydney", "Adam", "Anna", "Benjamin", "Olivia", "Chloe", "Kayla", "Molly", "Anthony", "Emily", "Avery", "Eva", "Ava", "Ashlyn", "Kylie", "Charlie", "Sienna", "Annabelle", "Alexandra", "Brayden", "Sean", "Jack", "Carter", "Nicholas", "Brianna", "Arianna", "Carson", "Austin", "Brandon", "Cameron", "Miles", "Riley", "Lucy", "Liam", "John", "Thomas", "Alexis", "Bentley", "Tristan", "Sadie", "Grace", "Andrew", "Jackson", "Elijah", "Summer", "Colton", "Connor", "Alyssa", "Jason", "Christian", "Emma", "Charlotte", "Isabelle", "Violet", "Blake", "Aubrey", "Asher", "Matthew", "Jake", "Isabella", "Tyler", "Juliana", "Kendall", "Riley", "Peyton", "Gavin", "Lauren", "Samuel", "Morgan", "Jace", "Addison", "James", "Bailey", "Ryder", "David", "Maria", "Paige", "Dylan", "Dominic", "Penelope", "Elizabeth", "Gabriella", "Caden", "Hadley", "Lila", "Sophia", "Jeremiah", "Scarlett", "Noah", "Ethan", "Chase", "Hayden", "Wyatt", "Zachary", "Isaiah"]
LAST_NAMES = ["Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Rotaru", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Tinsley", "Young", "Hernandez", "King", "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes"]
POSTCODES = ["N1 6ND", "LE11 2GZ", "N7 8AP", "N1 6ND", "EH54 6DZ", "BB1 7LT", "WD23 2JX", "NG18 5ET", "NG24 2EF", "ST9 0NG", "CR0 2RL", "CH65 6SB"]
LETTERS = Array('A'..'Z')

def rand_letters(number)
  return Array.new(number){LETTERS.sample}.join.to_s
end

def make_postcode()
 return rand_letters(2) + rand(9).to_s + ' ' + rand(9).to_s + rand_letters(2)
end

if (Claim.count != CLAIMS_COUNT)
  CLAIMS_COUNT.times do |i|

    puts "\tCreating claim #{i+1}"

    # Create a new claim
    claim = Claim.new

    # Scatter the created_at timestamps to have a more realistic spread between now and 14 days ago
    claim.created_at = (0..14).to_a.sample.days.ago.to_date
    claim.updated_at = claim.created_at

    # Assign some random cost and reserve values
    claim.claimant_name = "#{FIRST_NAMES.sample} #{LAST_NAMES.sample}"
    claim.claim_id = 1000+i
  	claim.postcode = make_postcode()
	  claim.policy_no = Array.new(8){rand(36).to_s(36)}.join.upcase

    claim.save
  end
end

puts "\n\r======================================"
puts "3. Assigning emails to claims"
puts "======================================"

# Assign a random sample of emails to this claim
claim_ids = Claim.all.collect(&:id)

puts "\tAssigning an average of #{EMAILS_PER_CLAIM_COUNT} emails per claim"
Email.only(:claim_id, :id).limit(CLAIMS_COUNT*EMAILS_PER_CLAIM_COUNT).only.each do |e|
 	e.set(claim_id: claim_ids.sample)
end

puts "\n\r   -> Done! (#{Claim.count} claims and #{Email.count} emails created)\n\r"
