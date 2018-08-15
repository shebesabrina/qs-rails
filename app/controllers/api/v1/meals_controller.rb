class Api::V1::MealsController < ApplicationController
  def index
    render json: Meal.all
  end

  def show
    render json: Meal.find(params[:id])
  rescue
    render status: 404
  end

  def create
    meal = Meal.find_by_id(params[:meal_id])
    food = Food.find_by_id(params[:id])
    if meal.nil? || food.nil?
      render status: 404
    else
      MealFood.create(food_id: food.id, meal_id: meal.id)
      render json: {"message": "Successfully added #{food.name} to #{meal.name}"}, status: 201
    end
  end

  def destroy
    meal = Meal.find_by_id(params["meal_id"])
    food = Food.find_by_id(params["id"])
    if meal.nil? || food.nil?
      render status: 404
    else
      meal_food = meal.meal_foods.find_by(food_id: food.id)
      meal_food.destroy
      render json: {"message": "Successfully removed #{food.name} from #{meal.name}"}
    end
  end
end
