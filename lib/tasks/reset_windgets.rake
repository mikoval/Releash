namespace :utility do
    desc "delete all animals"
    task :reset_widgets => :environment do

         User.update_all( dashboard:  "[{\"type\":\"animal-list\", \"x\":0, \"y\":0, \"height\": 4 , \"width\": 5},\n    {\"type\":\"user-list\", \"x\":5, \"y\":0, \"height\": 4 , \"width\": 5},\n    {\"type\":\"alert-list\", \"x\":0, \"y\":5, \"height\": 4 , \"width\": 5}]" )
    end
end
