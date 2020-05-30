require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end

    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録する'

        expect(page).to have_content 'アカウント登録が完了しました。'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '登録する'

        expect(page).to have_content 'エラー'
      end
    end
  end

  describe 'ユーザーログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context 'ログイン画面に遷移' do
      let(:test_user) { user }

      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'ログイン'

        expect(page).to have_content 'マイページ'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'かんたんログイン' do
    before do
      visit new_user_session_path
    end

    context 'ログイン画面に遷移' do
      it 'ログインに成功する' do
        click_link 'かんたんログイン'

        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:test_user2) { create(:user) }
  let!(:best) { create(:best, user: user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'マイページのテスト' do
    context '表示の確認' do
      it 'マイページと表示される' do
        expect(page).to have_content('マイページ')
      end
      it '画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it '名前が表示される' do
        expect(page).to have_content(user.name)
      end
      it '年齢が表示される' do
        expect(page).to have_content(user.age)
      end
      it '自己紹介が表示される' do
        expect(page).to have_content(user.introduction)
      end
      it '編集リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link '編集する', href: edit_user_path(user)
      end
      it 'お気に入り一覧リンクが表示される' do
        visit user_path(user)
        expect(page).to have_link 'お気に入り一覧', href: favorites_user_path(user)
      end
    end
  end

  describe 'ユーザー編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end

    context '他人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_user_path(test_user2)
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end

    context '表示の確認' do
      before do
        visit edit_user_path(user)
      end

      it 'ユーザ編集と表示される' do
        expect(page).to have_content('ユーザ編集')
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '性別設定フォームが表示される' do
        expect(page).to have_field 'user[sex]', with: user.sex
      end
      it '年代設定フォームが表示される' do
        expect(page).to have_field 'user[age]', with: user.age
      end
      it 'ユーザー名編集フォームに自分のユーザー名が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it 'プロフィール編集フォームに自分のプロフィールが表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '詳細設定リンクが表示される' do
        expect(page).to have_link '詳細設定', href: edit_user_registration_path(user)
      end
      it 'もどるリンクが表示される' do
        expect(page).to have_link 'もどる', href: user_path(user)
      end
      it '編集に成功する' do
        click_button '更新する'
        expect(current_path).to eq('/users/' + user.id.to_s)
        expect(page).to have_content 'プロフィールを編集しました'
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '更新する'
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end

  describe '一覧画面のテスト' do
    before do
      visit users_path
    end

    context '表示の確認' do
      it 'ユーザ一覧と表示される' do
        expect(page).to have_content('ユーザ一覧')
      end
      it '自分と他の人の画像が表示される' do
        expect(all('img').size).to eq(2)
      end
      it '自分と他の人のユーザー名が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content test_user2.name
      end
      it '自分と他の人の年代が表示される' do
        expect(page).to have_content user.age
        expect(page).to have_content test_user2.age
      end
      it '詳細リンクが表示される' do
        expect(page).to have_link '詳細', href: user_path(user)
        expect(page).to have_link '詳細', href: user_path(test_user2)
      end
    end
  end
end
