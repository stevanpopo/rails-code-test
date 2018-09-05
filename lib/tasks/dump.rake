namespace :dump do

  desc "Fetches some sample data and imports it into the local DB"
  task :seed_data, [:reseed] => [:environment] do |t, args|
    # Get the DB details
    mongo_config = YAML::load(File.open("#{Rails.root}/config/mongoid.yml"))["production"]["sessions"]["default"]
    db = mongo_config["database"]
    host = mongo_config["hosts"][0]
    username = mongo_config["username"]
    password = mongo_config["password"]

    # Remove the existing data
    system("rm -Rf #{Rails.root}/tmp/datadump/#{db}")
    
    puts "DUMPING DATA.............................."
    puts

    # Fetch the data from production DB
    system("mongodump -h #{host} -d #{db} -u #{username} -p #{password} -c claims -o '#{Rails.root}/tmp/datadump/'")
    system("mongodump -h #{host} -d #{db} -u #{username} -p #{password} -c emails -o '#{Rails.root}/tmp/datadump/'")

    puts
    puts "RESEEDING................................."
    Rake::Task["db:reset"].invoke
  end

end
