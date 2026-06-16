# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'そのユーザーが日報を編集できるか' do
    user = User.new(name: 'kouji', email: 'kouji@gmail.com')
    report = user.reports.build(title: 'test kouji', content: 'test Dr.kouji')
    assert report.editable?(user)
  end
  
  test '他のユーザーが他のユーザーの日報を編集できないか' do
    user = User.new(name: 'kouji', email: 'kouji@gmail.com')
    other_user = User.new(name: 'hitomi', email: 'hitomi@gmail.com')
    report = user.reports.build(title: 'test komeda', content: 'Lets Go, Dr.komeda kouji')
    assert_not report.editable?(other_user)
  end
end
