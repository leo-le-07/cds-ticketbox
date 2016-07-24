class OrderConfirmMailer < ApplicationMailer
  helper MailerHelper

  default from: "mrsmalldog001@gmail.com"

  def send_confirmation(order)
    @order = order
    mail(to: @order.email, subject: 'Xác nhận đặt hàng')
  end
end
