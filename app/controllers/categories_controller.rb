class CategoriesController < ApplicationController

  def index
    @categories = Category.where(category: "#{params[:sort_by]}")
    @title = Category.return_index_title(params[:sort_by])
  end

end
