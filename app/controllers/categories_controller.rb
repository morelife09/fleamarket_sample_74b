class CategoriesController < ApplicationController
  def create
    @category = Category.new(item_params)
  end
 
end
