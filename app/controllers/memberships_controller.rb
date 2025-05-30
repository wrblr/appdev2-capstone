class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[ show edit update destroy ]

  # GET /memberships or /memberships.json
  def index
    @memberships = current_user.memberships.includes(:group)
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  # def create
  #   @membership = Membership.new(membership_params)

  #   respond_to do |format|
  #     if @membership.save
  #       format.html { redirect_to @membership, notice: "Membership was successfully created." }
  #       format.json { render :show, status: :created, location: @membership }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @membership.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def create
  #   @group = Group.find_by(id: params[:membership][:group_id])

  #   # Automatically add the current user to the group
  #   Membership.find_or_create_by(user: current_user, group: @group)

  #   # Add any additional users selected from the form
  #   if params[:membership][:user_ids]
  #     user_ids = params[:membership][:user_ids].reject(&:blank?)
  #     user_ids.each do |id|
  #       Membership.find_or_create_by(user_id: id, group: @group)
  #     end
  #   end

  #   redirect_to memberships_path, notice: "Group created and users added!"
  # end

  def create
    @group = Group.find_by(id: params[:membership][:group_id])

    if @group.nil?
      redirect_to new_membership_path, alert: "Group not found."
      return
    end

    if @group.users.include?(current_user)
      redirect_to memberships_path, alert: "You're already a member of this group."
      return
    end

    # Add current user to group
    Membership.find_or_create_by(user: current_user, group: @group)

    # Add additional selected users
    if params[:membership][:user_ids]
      user_ids = params[:membership][:user_ids].reject(&:blank?)
      user_ids.each do |id|
        user = User.find_by(id: id)
        Membership.find_or_create_by(user: user, group: @group) if user && !@group.users.include?(user)
      end
    end

    redirect_to memberships_path, notice: "You successfully joined #{@group.name}!"
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    @membership.destroy!

    respond_to do |format|
      format.html { redirect_to memberships_path, status: :see_other, notice: "Membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = current_user.memberships.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def membership_params
    params.require(:membership).permit(:group_id, :user_id)
  end
end
