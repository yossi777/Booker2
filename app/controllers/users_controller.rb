class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only:[:edit, :update]}
  
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
    redirect_to user_path(current_user.id)
    end
  end
  
  def index
    @users = User.all
    @newbook = Book.new
    @user = current_user
  end
  
  def new
    @book = Book.new(book_params)
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # @book.save
    # redirect_to users_path,flash[:notice] = "You have created book successfully"
    
    if @book.save
      redirect_to users_path,flash[:notice] = "You have created book successfully"
    else
      @books= Book.all
      @user = current_user
      @newbook = Book.new
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @newbook = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	if @user.save
  		redirect_to user_path(@user.id)
      flash[:notice] = "Profile was successfully updated."
  	else
  		render :edit
  	end
  end
  
  
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
