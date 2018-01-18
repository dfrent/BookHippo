require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "user show page" do
    logged_in_user = create(:user)
    post sessions_url, params: {
      email: logged_in_user.email,
      password: logged_in_user.password
    }

    user = create(:user)
    user.follow(logged_in_user)
    get "/users/#{user.id}"

    assert_select "h3", "#{user.username.capitalize}'s Profile"

    assert_select ".following", "1"
    assert_select ".followers", "0"
  end

  test "user is created"  do
    user_params = {
      user: {
        email: "k@b.com",
        username: "k",
        password: "abcd12345",
        password_confirmation: "abcd12345"
      }
    }
    post "/users", params: user_params

    actual_email = User.last.email
    actual_username = User.last.username

    expected_email = user_params[:user][:email]
    expected_username = user_params[:user][:username]

    assert_equal(expected_email, actual_email)
    assert_equal(expected_username, actual_username)

    assert_redirected_to genres_url
  end


  test "path when user data is not valid" do
    user_params = {
      user: {
        email: "k@b.com",
        username: "k",
        password: "abcd",
        password_confirmation: "abcd"
      }
    }
    post "/users", params: user_params

    assert_equal(0, User.count)
    assert_equal '/users', path
  end

  test "the edit form displays the user's data" do
    user = create(:user)
    post sessions_url, params: {
      email: user.email,
      password: user.password
    }

    get "/users/#{user.id}/edit"

    # assert_select '#user_username', "#{user.username}"
    assert_select '#user_username' do
      assert_select "[value=?]", user.username
    end
  end

  test "user can update their information and save to the changes" do
    user = create(:user)
    post sessions_url, params: {
      email: user.email,
      password: user.password
    }

    patch "/users/#{user.id}", params:  {
      user:{
      username: 'eric',
      email: 'eric@bitmaker',
      password: 'abcd12345',
      password_confirmation: 'abcd12345'
    }}



    assert_equal('eric', user.reload.username)
    # test "should update post" do
    #   put :update, :id => @post.id, :post => { }
    #   assert_redirected_to post_path(assigns(:post))
    # end

  end


end
