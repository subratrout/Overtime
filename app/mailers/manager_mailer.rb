class ManagerMailer < ApplicationMailer
  def email(manager)
    @manager = manager
    mail(to: @manager.email, subject: "Daily Overtime request Email")
  end
end
