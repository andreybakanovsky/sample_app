class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]# чтобы без аутентификации не могли ничего изменить ))
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).order(created_at: :desc).paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) # Not the final implementation!
    # params[:user] на самом деле является хэшем атрибутов пользователя
    # is mostly equivalent to: @user = User.new(name: "Foo Bar", email: "foo@invalid", password: "foo", password_confirmation: "bar")
    if @user.save
      @user.send_activation_email # +
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
      # redirect_to @user # можно было так же redirect_to user_url(@user)
      # Так3ое возможно, потому что Rails автоматически определяет, что перенаправление
      # redirect_to @user должно быть выполнено в user_url(@user).
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    # !!! This code returns a version of the params hash with only the permitted attributes (while raising
    # an error if the :user attribute is missing).
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  # Чтобы обезопасить сайт, необходимо ограничить доступ к методу destroy,
  # чтобы только администраторы могли удалять пользователей.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
