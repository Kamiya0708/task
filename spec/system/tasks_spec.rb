require 'rails_helper'

describe 'タスク管理機能', type: :system do
  let(:user_a) {FactoryBot.create(:user, name: 'テストユーザA', email: 'a@user.test')}
  let(:user_b) {FactoryBot.create(:user, name: 'テストユーザB', email: 'b@user.test')}
  let!(:task_a) {FactoryBot.create(:task, name: 'タスクA1', user: user_a)}

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end

  shared_examples_for 'ユーザAタスク登録確認' do
    it {expect(page).to have_content 'タスクA1'}
  end

  describe '一覧表示機能' do
    context 'ユーザAログイン時' do
      let(:login_user) {user_a}

      it_behaves_like 'ユーザAタスク登録確認'
    end

    context 'ユーザBログイン時' do
      let(:login_user) {user_b}

      it '他ユーザのタスク非表示確認' do
        expect(page).to have_no_content 'タスクA1'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザAログイン時' do
      let(:login_user) {user_a}

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザAタスク登録確認'
    end
  end

  describe '新規作成機能' do
    let(:login_user) {user_a}

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録'
    end

    context '新規作成で名称を入力' do
      let(:task_name) {'新規作成テスト'}
      it '正常登録' do
        expect(page).to have_selector '.alert-success', text: '新規作成テスト'
      end
    end

    context '新規作成で名称を未入力' do
      let(:task_name) {''}

      it '未入力エラー' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end