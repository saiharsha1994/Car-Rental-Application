class NotifyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notify_mailer.new_notify.subject
  #

  def new_notify(car_id)
    Emailto.where(car_id: car_id).each {|email|
        puts "User email       #{email.email}"
        if User.find_by_id(email.user_id)
          puts "User email123       #{email.email}"
            @details=email
            mail to: email.email, subject: "Car Rental App Notification About Availability" do |format|
              format.html
            end
        end
    }
  end
end
