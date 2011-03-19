require 'test_helper'

class AdminControllerTest < ActionController::TestCase
   setup do
    @match = matches(:one)
    @update = {
      :home_team => 'Ruritania',
      :away_team => 'Titipu',
      :date_match => '2011-02-17'
    }
  end

  test "should create match" do
    assert_difference('Match.count') do
      post :enter_match, :match => @update
    end

  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get enter_tournament" do
    get :enter_tournament
    assert_response :success
  end

end
