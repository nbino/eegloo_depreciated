require File.dirname(__FILE__) + '/../test_helper'

class ListingInfosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:listing_infos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_listing_info
    assert_difference('ListingInfo.count') do
      post :create, :listing_info => { }
    end

    assert_redirected_to listing_info_path(assigns(:listing_info))
  end

  def test_should_show_listing_info
    get :show, :id => listing_infos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => listing_infos(:one).id
    assert_response :success
  end

  def test_should_update_listing_info
    put :update, :id => listing_infos(:one).id, :listing_info => { }
    assert_redirected_to listing_info_path(assigns(:listing_info))
  end

  def test_should_destroy_listing_info
    assert_difference('ListingInfo.count', -1) do
      delete :destroy, :id => listing_infos(:one).id
    end

    assert_redirected_to listing_infos_path
  end
end
