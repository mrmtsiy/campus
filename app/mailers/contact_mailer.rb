class ContactMailer < ApplicationMailer
  default from: ENV['SMTP_USERNAME']

  def contact_mail(contact)
    @contact = contact
    mail(
      subject: "お問い合わせありがとうございます",
      to: ENV['SMTP_USERNAME']
    )
  end
end
