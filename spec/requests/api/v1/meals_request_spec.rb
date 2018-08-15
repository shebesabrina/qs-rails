require 'rails_helper'

describe 'Meals API' do
  it 'returns all meals in database' do
    create_list(:meal, 3)

    get '/api/v1/meals'

    expect(response).to be_successful

    meals = JSON.parse(response.body, symbolize_names: true)
    expect(meals.count).to eq(3)
  end

  it "can get one meal by its id" do

    get "/api/v1/meals/8675309/foods"

    expect(status).to eq(404)

    breakfast = create(:meal, name: 'breakfast')
    expect(Food.count).to eq(0)

    4.times do
      food = create(:food)
      breakfast.foods << food
    end

    get "/api/v1/meals/#{breakfast.id}/foods"

    expect(response).to be_success

    meal_response = JSON.parse(response.body, symbolize_names: true)
    foods = meal_response[:foods]
    
    expect(foods.count).to eq(breakfast.foods.count)
  end

  it 'creates a new meal id' do
    post '/api/v1/meals/8675309/foods/8675309'

    expect(status).to eq(404)

    meal = create(:meal)
    food = create(:food)
    post "/api/v1/meals/#{meal.id}/foods/#{food.id}"

    expect(response).to be_success
    message = JSON.parse(response.body, symbolize_names: true)
    expect(message[:message]).to eq("Successfully added #{food.name} to #{meal.name}")
    expect(meal.foods).to eq([food])
    expect(status).to eq(201)
  end

  it 'deletes a food item from a meal' do
    delete '/api/v1/meals/8675309/foods/8675309'

    meal = create(:meal)
    food = meal.foods.create(name: 'blueberries', calories: '150')
    delete "/api/v1/meals/#{meal.id}/foods/#{food.id}"

    expect(response).to be_success
    message = JSON.parse(response.body, symbolize_names: true)
    expect(message[:message]).to eq("Successfully removed #{food.name} from #{meal.name}")
  end
end
