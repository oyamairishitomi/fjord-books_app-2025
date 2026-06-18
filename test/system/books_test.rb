# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:kouji)
    @user = users(:kouji)
    sign_in_as @user
  end

  test '本の一覧ページを表示できる' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
    assert_text 'こうじの内科ブック'
  end

  test '本を作成できる' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'タイトル', with: 'こうじがゆく'
    fill_in 'メモ', with: '内科医こうじのドタバタ喜劇'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text 'こうじがゆく'
  end

  test '本を更新できる' do
    visit book_url(@book)
    click_on 'この本を編集', match: :first

    fill_in 'タイトル', with: 'こうじのテスト大戦'
    fill_in 'メモ', with: '３０代から医学部挑戦、テストとの戦いの全記録'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'こうじのテスト大戦'
  end

  test '本を削除できる' do
    visit book_url(@book)
    click_on 'この本を削除', match: :first

    assert_text '本が削除されました。'
    assert_no_text 'こうじの内科ブック'
  end
end
