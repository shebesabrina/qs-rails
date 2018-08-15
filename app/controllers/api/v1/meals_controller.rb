class Api::V1::MealsController < ApplicationController
  def index
    meals = Meal.all
    meals_and_foods = meals.map do |meal|
      {
        id: meal.id,
        name: meal.name,
        foods: meal.foods
      }
    end
    render json: meals_and_foods
  end

  def show
    meal = Meal.find(params[:id])
    render json: {
      id: meal.id,
      name: meal.name,
      foods: meal.foods
    }
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
