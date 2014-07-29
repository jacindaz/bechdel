class CategoriesController < ApplicationController

  def index
    if params[:sort_by] == "box"
      @categories = Category.where(category: 'box_office')
    else
      @categories = Category.where(category: params[:sort_by])
    end
    #binding.pry

    @title = Category.return_index_title(params[:sort_by])
  end

end
