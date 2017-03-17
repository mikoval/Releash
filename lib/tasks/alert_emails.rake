namespace :utility do
    desc "Send Alert Emails"
    task :alert_emails => :environment do

        alerts = Alert.where(:date => Time.now..1.month.from_now)
        alerts.each do |alert|
            users = []
            usersAlerts = UserAlert.where ("alert_id = " + alert.id.to_s)

            usersAlerts.each do |user|
                users.append(user.user)
            end

            users.each do |user|
                UserMailer.alert_email(user, alert).deliver_now
            end
        end
    end
end
