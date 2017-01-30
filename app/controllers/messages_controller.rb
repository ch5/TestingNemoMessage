require 'nexmo'

class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  autocomplete :phone, :name, :full => true
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/new
  def new
    @message = Message.new
    @messagges = Message.sorted
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        nexmo = Nexmo::Client.new(key: 'cd9ad5ec', secret: 'cccedae657c0df77')
        nexmo.send_message(from: 'Me', to:@message.phone.number, text: @message.text)
        format.html { redirect_to new_message_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:text, :phone_id)
    end

end
