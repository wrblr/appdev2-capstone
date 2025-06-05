class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
    if params[:user_id] # private chat
      @recipient = User.find(params[:user_id])
      @messages = Message.where(sender_id: current_user.id, recipient_id: @recipient.id)
                         .or(Message.where(sender_id: @recipient.id, recipient_id: current_user.id))
                         .order(:created_at)
      @message = Message.new(sender_id: current_user.id, recipient_id: @recipient.id)
    elsif params[:group_id] # group chat
      @group = Group.find(params[:group_id])
      @messages = @group.messages.order(:created_at)
      @message = Message.new(sender_id: current_user.id, group_id: @group.id)
    else
      # fallback - optional
      @messages = Message.none
      @message = Message.new
    end
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  # def create
  #   @message = Message.new(message_params)

  #   respond_to do |format|
  #     if @message.save
  #       format.html { redirect_to @message, notice: "Message was successfully created." }
  #       format.json { render :show, status: :created, location: @message }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @message.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    @message = Message.new(message_params)

    if @message.group_id.present?
      @group = Group.find(@message.group_id)
    else
      @recipient = User.find(@message.recipient_id)
    end

    if current_user.preferred_language_id != @recipient.preferred_language_id
      @source_lang = current_user.preferred_language.iso_code
      @target_lang = @recipient.preferred_language.iso_code
      translated_text = TranslationsController.translate_text(
        original_text: @message.body,
        source_lang: @source_lang,
        target_lang: @target_lang,
      )
      @message.translated_body = translated_text
    end

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html do
          if @group
            redirect_to group_path(@group)
          else
            redirect_to chat_user_path(@recipient)
          end
        end
      end
    else
      flash[:alert] = "Message could not be sent."
      if @group
        redirect_to group_path(@group)
      else
        redirect_to chat_user_path(@recipient)
      end
    end
  end

  def private_chat
    @recipient = User.find(params[:recipient_id])

    @messages = Message
      .where(sender_id: current_user.id, recipient_id: @recipient.id)
      .or(Message.where(sender_id: @recipient.id, recipient_id: current_user.id))
      .order(:created_at)

    @message = Message.new(
      sender_id: current_user.id,
      recipient_id: @recipient.id,
      original_language_id: current_user.preferred_language_id,
    )
  end

  def new_private
    # Step 1: Exclude yourself
    all_other_users = User.where.not(id: current_user.id)

    # Step 2: Find existing chat partners (from messages where you're sender or recipient)
    existing_chat_partner_ids = Message
      .where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
      .pluck(:sender_id, :recipient_id)
      .flatten
      .uniq
      .reject { |id| id == current_user.id }

    # Step 3: Only users you haven't chatted with yet
    @users = all_other_users.where.not(id: existing_chat_partner_ids)
  end

  def group_chat
    @group = Group.find(params[:group_id])
    @message = Message.new(sender_id: current_user.id, group_id: @group.id)
    @messages = @group.messages.order(:created_at)
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_path, status: :see_other, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
  end

  # Only allow a list of trusted parameters through.
  def message_params
    # params.expect(message: [:group_id, :sender_id, :audio, :video, :body, :original_language_id])
    # params.require(:message).permit(:group_id, :sender_id, :audio, :video, :body, :original_language_id)
    params.require(:message).permit(:group_id, :sender_id, :recipient_id, :body, :original_language_id)
  end
end
