require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = create :task
    @user = create(:user, name: 'jimmy', email: 'jimmy@mail.com')

    post login_path, params: {
      email: @user.email,
      password: 'password'
    }

    assert_equal 'Logged in successfully', flash.notice
    assert_response :redirect
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end

  test 'should get new' do
    get new_task_url
    assert_response :success
  end

  test 'should create task' do
    assert_difference('Task.count') do
      post tasks_url,
           params: { task: {
             due_date: 'Sun, 20 Oct 2022',
             name: 'Task 1',
             user_id: @user.id
           } }
    end

    assert_redirected_to tasks_url
  end

  test 'should raise error if form submitted without values i.e blank name and due_date' do
    post tasks_url,
         params: { task: {
           due_date: nil,
           name: '',
           user_id: @user.id
         } }

    assert_equal ["Name can't be blank", 'Name is too short (minimum is 4 characters)', "Due date can't be blank"],
                 assigns(:task).errors.full_messages
    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should raise error if form submitted without due_date ' do
    post tasks_url,
         params: { task: {
           due_date: nil,
           name: 'Task 1',
           user_id: @user.id
         } }

    assert_equal "Due date can't be blank", flash.notice
    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should raise error if form submitted without/blank task name ' do
    post tasks_url,
         params: { task: {
           due_date: 'Sun, 20 Oct 2022',
           name: nil,
           user_id: @user.id
         } }

    assert_equal ["can't be blank", 'is too short (minimum is 4 characters)'],
                 assigns(:task).errors[:name]
    assert_response :unprocessable_entity
    assert_template :new
  end

  test 'should get edit' do
    get edit_task_url(@task)
    assert_response :success
  end

  test 'should be able to update task' do
    patch task_url(@task), params: { task: { name: 'Go out for a walk.', due_date: 'Tue, 25 Oct 2022' } }

    assert_response :redirect
    assert_redirected_to tasks_path
    assert_equal 'Go out for a walk.', @task.reload.name
    assert_equal Date.parse('Tue, 25 Oct 2022'), @task.reload.due_date
  end

  test 'should destroy task' do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
