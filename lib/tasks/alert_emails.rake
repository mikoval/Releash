namespace :utility do
    desc "Send Alert Emails"
    task :alert_emails => :environment do

        alerts = Alert.where(:date => Time.now..1.month.from_now)
        alerts.each do |alert|
            usersAlerts = UserAlert.where ("alert_id = " + alert.id.to_s)

            usersAlerts.each do |user|
                if((alert.date.to_datetime.to_i - Time.now.to_i )  / 1.hour <= 1 &&  (alert.date.to_datetime.to_i - Time.now.to_i )  / 1.hour >=0&&  (Time.now.to_i - user.email_date.to_datetime.to_i)  / 1.hour >2
                 )
                    
                    UserMailer.alert_email_upcoming(user.user, alert).deliver_now
                    user.update_attributes(email_date: Time.now)
                elsif (

                    (alert.date.to_datetime.to_i - Time.now.to_i )/1.day < 0 &&  (Time.now.to_i - user.email_date.to_datetime.to_i)  / 1.day >=1 && 
                    ( @alert.required == "1" || @alert.required == "true" || @alert.required == true) && (@alert.completed == "1"  || @alert.completed == true || @alert.completed == "true")) 

                    UserMailer.alert_email_overdue(user.user, alert).deliver_now
                    user.update_attributes(email_date: Time.now)

                end


    
            end

        end
    end
end
