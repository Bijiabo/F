class CatsController < ApplicationController
  def index
    page = 1
    page = Integer(params[:page]) > 0 ? params[:page] : 1 if params[:page]

    @cats = Cat.paginate(page: page)

  end

  def show

  end

  def new
    @user = current_user
    @cat = @user.cats.new
  end

  def edit

  end

  def create

  end

  def update

  end

  def destroy

  end

  private

    def cat_params
      params.require(:cat).permit(:name, :age, :breed, :user_id)
    end

end
