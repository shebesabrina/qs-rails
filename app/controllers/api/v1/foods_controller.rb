class Api::V1::FoodsController < ApplicationController

  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  rescue
    render status: 404
  end

  def create
    food = Food.new(food_params)
    if food.save
      render json: food
    else
      render status: 400
    end
  end

  def update
    render json: Food.update(params[:id], food_params)
  rescue
    render status: 400
  end

  def destroy
    render json: Food.destroy(params[:id]), status: 204
  rescue
    render status: 404
  end

  private

  def food_params
    params.require(:food).permit(:name, :calories)
  end
end
