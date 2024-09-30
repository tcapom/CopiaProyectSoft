require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @user = users(:bueno)
    sign_in @user
  end

  test "should create message" do
    chat_room = chat_rooms(:one)
    assert_difference('Message.count') do
      post chat_room_messages_url(chat_room), params: { message: { content: 'Mensajote de texto' } }
    end
    assert_redirected_to chat_room_url(chat_room)
  end

  #test "should not create message with invalid params" do
  #  chat_room = chat_rooms(:one)
  #  assert_no_difference('Message.count') do
  #    post chat_room_messages_url(chat_room), params: { message: { content: '' } }
  #  end
  #  assert_response :success
  #end
end