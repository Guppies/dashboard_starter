class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users -= [current_user]
  end

  def create
    if @user.save
      flash[:success] = 'Created Successfully'
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def update
    if @user.save
      flash[:success] = 'Updated Successfully'
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = 'Deleted Successfully'
    else
      flash.now[:error] = @user.errors.full_messages
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
