# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'nameがあればnameを返す' do
    user = User.new(name: 'kouji', email: 'kouji@gmail.com')
    assert_equal 'kouji', user.name_or_email
  end

  test 'nameがからの時、emailを返す' do
    user = User.new(name: '', email: 'kouji@gmail.com')
    assert_equal 'kouji@gmail.com', user.name_or_email
  end
end
