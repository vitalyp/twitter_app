class NotifiesControllerController < ApplicationController
  def create
    msg = params[:m]
    number = params[:n]
    account_sid = 'ACfad7989b8e939206efa0ab4cd655faa7'
    auth_token = 'd47b0f6c859880ffe887cda631789aed'
    @client = Twilio::REST::Client.new account_sid, auth_token
    #@to = "+380939722093"
    @to = number.start_with?('+38') ? number : '+38'+number
    @from = "+14807393905"
    message = @client.account.messages.create(:body => msg,
                                              :to => @to,
                                              :from => @from)
    puts message.sid
    render text: "Сообщение отправлено. <a href='http://sms-app-vitalyp.c9.io/'>Назад!</a>"
  end
end
