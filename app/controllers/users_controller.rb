class UsersController < ApplicationController
  # def index
  #   @users = User.all
  # end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)   # Not the final implementation!
    # params[:user] на самом деле является хэшем атрибутов пользователя
    # is mostly equivalent to: @user = User.new(name: "Foo Bar", email: "foo@invalid", password: "foo", password_confirmation: "bar")
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # можно было так же redirect_to user_url(@user)
      # Так3ое возможно, потому что Rails автоматически определяет, что перенаправление
      # redirect_to @user должно быть выполнено в user_url(@user).
    else
      render 'new'
    end
  end

  private

    def user_params
      # !!! This code returns a version of the params hash with only the permitted attributes (while raising
      # an error if the :user attribute is missing).
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
