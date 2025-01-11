require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "#index" do
    context "認証済みのユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end
      fit "正常にレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to be_successful
      end
      fit "200のレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "ゲスト・ユーザーとして" do
      fit "302レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status(302)
      end

      fit "サインイン画面にリダイレクトすること" do
        get :index
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end
end
