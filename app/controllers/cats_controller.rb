class CatsController < ApplicationController
  def index
    page = 1
    page = Integer(params[:page]) > 0 ? params[:page] : 1 if params[:page]

    @cats = Cat.paginate(page: page)
    render json: @cats
  end
end
