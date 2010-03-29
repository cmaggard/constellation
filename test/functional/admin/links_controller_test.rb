require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/links_controller'

# Re-raise errors caught by the controller.
class Admin::LinksController; def rescue_action(e) raise e end; end

class Admin::LinksControllerTest < Test::Unit::TestCase
  fixtures :links, :technicians

  def setup
    @controller = Admin::LinksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:technician] = technicians(:cody).id
    @request.session[:admin] = true
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:links)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:link)
    assert assigns(:link).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:link)
  end

  def test_create
    num_links = Link.count

    post :create, :link => {:link => "www.espn8.com", :title => "The Ocho"}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_links + 1, Link.count
  end
  
  def test_create_invalid
    num_links = Link.count
    
    post :create, :link => {}
    
    assert_response :success
    assert_template 'new'
    
    assert_equal num_links, Link.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:link)
    assert assigns(:link).valid?
  end
  
  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_update_invalid
    link = Link.find(1)
    link.title = ""
    post :update, { :id => 1, :link => link.attributes }
    assert_response :success
    assert_template 'edit'
  end

  def test_destroy
    assert_not_nil Link.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Link.find(1)
    }
  end
end
