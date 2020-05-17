require 'rails_helper'

RSpec.describe 'commentモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(BestComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Bestモデルとの関係' do
      it 'N:1となっている' do
        expect(BestComment.reflect_on_association(:best).macro).to eq :belongs_to
      end
    end
  end
end