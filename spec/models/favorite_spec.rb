require 'rails_helper'

RSpec.describe 'favotiteモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Bestモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:best).macro).to eq :belongs_to
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end

end