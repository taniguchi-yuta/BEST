require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:best) { create(:best, user: user) }
  let!(:best2) { create(:best, user: user2) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'BEST投稿のテスト' do
    before do
      visit new_best_path
    end

    context '表示の確認' do
      it '新規投稿と表示される' do
        expect(page).to have_content '新規投稿'
      end
      it 'BEST名称フォームが表示される' do
        expect(page).to have_field 'best[best_name]'
      end
      it 'URLフォームが表示される' do
        expect(page).to have_field 'best[best_url]'
      end
      it '紹介文フォームが表示される' do
        expect(page).to have_field 'best[recommend]'
      end
      it '投稿するボタンが表示される' do
        expect(page).to have_button '投稿する'
      end
      it '投稿に成功する' do
        fill_in 'best[best_name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'best[best_url]', with: Faker::Internet.url
        fill_in 'best[recommend]', with: Faker::Lorem.characters(number: 20)
        click_button '投稿する'
        expect(current_path).to eq(bests_path)
      end
      it '投稿に失敗する' do
        click_button '投稿する'
        expect(page).to have_content 'BEST名称を入力してください'
        expect(current_path).to eq('/bests')
      end
    end
  end

  describe 'BEST編集のテスト' do
    context '自分の投稿の編集画面への遷移' do
      it '遷移できる' do
        visit edit_best_path(best)
        expect(current_path).to eq('/bests/' + best.id.to_s + '/edit')
      end
    end

    context '他人の投稿の編集画面への遷移' do
      it '遷移できない' do
        visit edit_best_path(best2)
        expect(current_path).to eq(user_path(user))
      end
    end

    context '表示の確認' do
      before do
        visit edit_best_path(best)
      end

      it 'BEST名称フォームが表示される' do
        expect(page).to have_field 'best[best_name]'
      end
      it 'URLフォームが表示される' do
        expect(page).to have_field 'best[best_url]'
      end
      it '紹介文フォームが表示される' do
        expect(page).to have_field 'best[recommend]'
      end
      it '更新するボタンが表示される' do
        expect(page).to have_button '更新する'
      end
    end

    context 'フォームの確認' do
      it '編集に成功する' do
        visit edit_best_path(best)
        click_button '更新する'
        expect(current_path).to eq '/bests/' + best.id.to_s
      end
      it '編集に失敗する' do
        visit edit_best_path(best)
        fill_in 'best[best_name]', with: ''
        click_button '更新する'
        expect(page).to have_content 'BEST名称を入力してください'
        expect(current_path).to eq '/bests/' + best.id.to_s
      end
    end
  end

  describe 'BEST一覧画面のテスト' do
    before do
      visit bests_path
    end

    context '表示の確認' do
      it 'BEST一覧と表示される' do
        expect(page).to have_content 'BEST一覧'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: best_path(best)
        expect(page).to have_link '', href: best_path(best2)
      end
      it '自分と他人のBEST名称が表示される' do
        expect(page).to have_content best.best_name
        expect(page).to have_content best2.best_name
      end
    end
  end
end
