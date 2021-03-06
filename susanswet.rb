class UsersController < ApplicationController

 before_action :load_user, only: [:show, :edit, :create, :update, :destroy]

 def index
   @users = User.all
 end

 def show
 end

 def new
   @user = User.new
 end

 def edit
 end

 def create
   respond_to do |format|
     if @user.save
       format.html { redirect_to @user, notice: 'User was successfully created.' }
       format.json { render :show, status: :created, location: @user }
     else
       format.html { render :new }
       format.json { render json: @user.errors, status: :unprocessable_entity }
     end
   end

   Slack.notify_channel
 end

 def update
   respond_to do |format|
     if @user.update(user_params)
       format.html { redirect_to @user, notice: 'User was successfully updated.' }
       format.json { render :show, status: :ok, location: @user }
     else
       format.html { render :edit }
       format.json { render json: @user.errors, status: :unprocessable_entity }
     end
   end

   Slack.notify_channel
 end

 def destroy
   @user.destroy
   respond_to do |format|
     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
     format.json { head :no_content }
   end

   Slack.notify_channel
 end

 private

   def load_user
     @user = User.find(params[:id])
   end


   def user_params
     params.require(:user).permit(:username, :email)
   end
end
