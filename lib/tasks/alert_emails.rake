namespace :utility do
    desc "Send Alert Emails"
    task :alert_emails => :environment do

        alerts = Alert.where(:date => Time.now..1.month.from_now)
        alerts.each do |alert|
            usersAlerts = UserAlert.where ("alert_id = " + alert.id.to_s)

            usersAlerts.each do |user|
                if(user.email_date == nil || (Time.now.to_i - user.email_date.to_datetime.to_i) / 1.hour < 1)
                    
                    UserMailer.alert_email(user.user, alert).deliver_now
                    user.update_attributes(email_date: Time.now)
                end
            end

        end
    end
end
