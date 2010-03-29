require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/technician_controller'

# Re-raise errors caught by the controller.
class Admin::TechnicianController; def rescue_action(e) raise e end; end

class Admin::TechnicianControllerTest < Test::Unit::TestCase
  fixtures :technicians

  def setup
    @controller = Admin::TechnicianController.new
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

    assert_not_nil assigns(:technicians)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:technician)
    assert assigns(:technician).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:technician)
  end

  def test_create
    num_technicians = Technician.count

    post :create, :technician => {:name => "Dan Embrey", :initials => "DE"}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_technicians + 1, Technician.count
  end

  def test_create_invalid
    num_technicians = Technician.count
    
    post :create, :technician => {}

    assert_response :success
    assert_template 'new'

    assert_equal num_technicians, Technician.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:technician)
    assert assigns(:technician).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end
  
  def test_update_invalid
    tek = Technician.find(1)
    tek.name = ""
    
    post :update, { :id => 1, :technician => tek.attributes }
    assert_response :success
    assert_template 'edit'
  end
end
