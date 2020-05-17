require 'rails_helper'

RSpec.describe 'Bestモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:best) { build(:best, user_id: user.id) }

    context 'best_nameカラム' do
      it '空欄でないこと' do
        best.best_name = ''
        expect(best.valid?).to eq false
      end
    end

    describe 'アソシエーションのテスト' do
      context 'Userモデルとの関係' do
        it 'N:1となっている' do
          expect(Best.reflect_on_association(:user).macro).to eq :belongs_to
        end
      end
      context 'favoriteモデルとの関係' do
        it '1:Nとなっている' do
          expect(Best.reflect_on_association(:favorites).macro).to eq :has_many
        end
      end
      context 'commentモデルとの関係' do
        it '1:Nとなっている' do
          expect(Best.reflect_on_association(:best_comments).macro).to eq :has_many
        end
      end
    end
  end
end
