class ContactsController < ApplicationController
  def index
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      MessageMailer.contact_us_message(@message).deliver
      redirect_to contact_path, notice: "Got it! Thank you for contacting us."
    else
      # flash[:alert] = "An error occurred while delivering this message."
      render :index
    end
  end

private

  def message_params
    params.require(:message).permit(:name, :email, :phone, :content)
  end
end
