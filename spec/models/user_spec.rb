require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { test_user.valid? }

    let(:user) { build(:user) }

    context 'nameカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false
      end
      it '10文字以下であること' do
        test_user.name = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      let(:test_user) { user }

      it '200文字以下であること' do
        test_user.introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Bestモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:bests).macro).to eq :has_many
      end
    end

    context 'favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:best_comments).macro).to eq :has_many
      end
    end
  end
end
