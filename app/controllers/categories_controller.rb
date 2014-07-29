class CategoriesController < ApplicationController

  def index
    @categories = Category.where(category: "#{params[:sort_by]}")
    @title = "#{params[:sorty_by]}"
  end

end
