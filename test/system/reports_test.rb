# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:kouji)
    @user = users(:kouji)
    sign_in_as @user
  end

  test '日報の一覧ページを表示できる' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
    assert_text '今日のテスト勉強について'
  end

  test '日報を作成できる' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '誤診王こうじの護身術'
    fill_in '内容', with: '患者の病気を見抜いた。お礼に栗羊羹をもらった。おいしかった。'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '誤診王こうじの護身術'
  end

  test '日報を更新できる' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: '更新後のタイトル'
    fill_in '内容', with: '更新後の内容'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '更新後のタイトル'
  end

  test '日報を削除できる' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
    assert_no_text 'MyString'
  end
end
