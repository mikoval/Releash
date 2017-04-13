namespace :utility do
    desc "delete all animals"
    task :delete_animals => :environment do

        Animal.delete_all
    end
end
