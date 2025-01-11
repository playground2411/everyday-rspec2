require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "#index" do
    context "認証済みのユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to be_successful
      end
      it "200のレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "ゲスト・ユーザーとして" do
      it "302レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status(302)
      end

      it "サインイン画面にリダイレクトすること" do
        get :index
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end

  describe "#show" do
    before do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, owner: @user)
    end
    context "認証済みのユーザーとして" do
      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @project.id }
        expect(response).to be_successful
      end
      it "200のレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @project.id }
        expect(response).to have_http_status(200)
      end
    end

    context "ゲスト・ユーザーとして" do
      it "302レスポンスを返すこと" do
        get :show, params: { id: @project.id }
        expect(response).to have_http_status(302)
      end

      it "サインイン画面にリダイレクトすること" do
        get :show, params: { id: @project.id }
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end
end
