require 'rails_helper'

describe "Foods API" do
  it "returns all foods in database" do
    get '/api/v1/foods'

    expect(response).to be_successful
    foods = JSON.parse(response.body,  symbolize_names: true)
    expect(foods.count).to eq(0)

    food_list = create_list(:food, 3)
    foods = JSON.parse(response.body,  symbolize_names: true)
    expect(food_list.count).to eq(3)
  end

  it "can get one food item by its id" do
    get '/api/v1/foods/8675309'
    expect(status).to eq(404)

    id = create(:food).id

    get "/api/v1/foods/#{id}"

    food = JSON.parse(response.body,  symbolize_names: true)

    expect(response).to be_successful
    expect(food[:id]).to eq(id)
  end

  it "can create a new food item" do
    food_params = { name: "strawberry", calories: 100 }

    post "/api/v1/foods", params: {food: food_params}
    food = Food.last

    assert_response :success
    expect(response).to be_successful
    expect(Food.count).to eq(1)
    expect(food.name).to eq(food_params[:name])
  end

  it "can update an existing food item" do
    params = { name: "strawberry" }
    put '/api/v1/foods/8675309', params: params
    expect(status).to eq(400)

    id = create(:food).id

    previous_name = Food.last.name
    food_params = { name: "strawberry" }

    put "/api/v1/foods/#{id}", params: {food: food_params}
    food = Food.find_by(id: id)

    expect(response).to be_successful
    expect(food.name).to_not eq(previous_name)
    expect(food.name).to eq("strawberry")
  end

  it "can destroy a food item" do
    delete '/api/v1/foods/8675309'
    expect(status).to eq(404)

    food = create(:food)

    expect(Food.count).to eq(1)

    delete "/api/v1/foods/#{food.id}"

    expect(response).to be_successful
    expect(Food.count).to eq(0)
    expect{Food.find(food.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
