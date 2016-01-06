require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new player" do
    get :new
    assert_response :success
    assert_not_nil assigns(:player)
  end

  test "should show player" do
    get(:show, { "id" => "1" })
    assert_response :success
    assert_not_nil assigns(:player)
    assert_not_nil assigns(:history)
  end

  test "should create player" do
    assert_difference("Player.count") do
      post :create, player: {
        name: "New Player",
        password: "password",
        password_confirmation: "password"
      }
    end
    assert_redirected_to players_path
  end

  test "should log in as player" do
    Player.stubs(:find_by).returns(Player.first)
    Player.any_instance.stubs(:authenticate).returns(true)

    player = {
        name: "New Player",
        password: "password"
      }

    post :login, player: player

    assert_response :redirect
    assert_not(flash[:error], "Shouldn't be errors when logging in")
  end

end
