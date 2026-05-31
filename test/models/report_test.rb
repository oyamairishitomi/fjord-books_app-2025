# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'そのユーザーが日報を編集できるか' do
    user = User.new(name: 'kouji', email: 'kouji@gmail.com')
    report = Report.new(user: user, title: 'test kouji', content: 'test Dr.kouji')
    assert report.editable?(user)
  end
end
