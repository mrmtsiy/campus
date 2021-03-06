class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver_now
      redirect_to contact_thanks_path(@contact), notice: "お問い合わせ内容を送信しました"
    else
      redirect_to new_contact_path, alert: "お問い合わせの送信に失敗しました"
    end
  end

  def thanks
  end
  
  
  private
    def contact_params
      params.require(:contact).permit(:name, :message, :email)
    end
    
end
