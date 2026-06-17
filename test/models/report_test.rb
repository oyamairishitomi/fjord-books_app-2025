# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'そのユーザーが日報を編集できるか' do
    user = users(:kouji)
    report = reports(:kouji)
    assert report.editable?(user)
  end

  test '他のユーザーが他のユーザーの日報を編集できないか' do
    other_user = users(:hitomi)
    report = reports(:kouji)
    assert_not report.editable?(other_user)
  end
end
