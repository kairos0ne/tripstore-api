require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trip = trips(:one)
  end

  test "should get index" do
    get trips_url, as: :json
    assert_response :success
  end

  test "should create trip" do
    assert_difference('Trip.count') do
      post trips_url, params: { trip: { arrival_airport_code: @trip.arrival_airport_code, arrival_time: @trip.arrival_time, departure_airport_code: @trip.departure_airport_code, departure_time: @trip.departure_time, destination: @trip.destination, end_date: @trip.end_date, start_date: @trip.start_date, user_id: @trip.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show trip" do
    get trip_url(@trip), as: :json
    assert_response :success
  end

  test "should update trip" do
    patch trip_url(@trip), params: { trip: { arrival_airport_code: @trip.arrival_airport_code, arrival_time: @trip.arrival_time, departure_airport_code: @trip.departure_airport_code, departure_time: @trip.departure_time, destination: @trip.destination, end_date: @trip.end_date, start_date: @trip.start_date, user_id: @trip.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy trip" do
    assert_difference('Trip.count', -1) do
      delete trip_url(@trip), as: :json
    end

    assert_response 204
  end
end