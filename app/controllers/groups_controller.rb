class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  # def create
  #   @group = Group.new(group_params)

  #   respond_to do |format|
  #     if @group.save
  #       format.html { redirect_to @group, notice: "Group was successfully created." }
  #       format.json { render :show, status: :created, location: @group }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @group.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def create
    @group = Group.new(group_params)
    if @group.save
      # Add current user as a member
      Membership.find_or_create_by(user: current_user, group: @group)

      # Add selected users
      if params[:group][:user_ids]
        params[:group][:user_ids].reject(&:blank?).each do |user_id|
          Membership.find_or_create_by(user_id: user_id, group: @group)
        end
      end

      redirect_to memberships_path, notice: "Group created and members added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_path, status: :see_other, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.expect(group: [:name, :image, :messages_count])
  end
end
