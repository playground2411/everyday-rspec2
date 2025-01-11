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

    context "認証済みの他ユーザーとして" do
      before do
        @user_b = FactoryBot.create(:user)
      end
      it "302レスポンスを返すこと" do
        sign_in @user_b
        get :show, params: { id: @project.id }
        expect(response).to have_http_status(302)
      end

      it "ホーム画面にリダイレクトすること" do
        sign_in @user_b
        get :show, params: { id: @project.id }
        expect(response).to redirect_to("/")
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

  describe "#update" do
    context "認証済みのユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: @user)
      end
      context "有効な属性値の場合" do
        it "更新されていること" do
          project_params = FactoryBot.attributes_for(
            :project,
            name: "Changed by Test!"
          )
          sign_in @user
          patch :update, params: {
            id: @project.id,
            project: project_params
          }
          expect(@project.reload.name).to eq("Changed by Test!")
        end
      end

      context "無効な属性値の場合" do
        fit "更新されていないこと" do
          project_params = FactoryBot.attributes_for(
            :project,
            name: nil
          )
          sign_in @user
          patch :update, params: {
            id: @project.id,
            project: project_params
          }
          expect(@project.reload.name).to_not eq(nil)
        end
      end
    end

    context "ゲスト・ユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: @user)
      end
      it "302レスポンスを返すこと" do
        project_params = FactoryBot.attributes_for(
          :project,
          name: "Changed by Test!"
        )
        patch :update, params: {
          id: @project.id,
          project: project_params
        }
        expect(response).to have_http_status(302)
      end

      it "サインイン画面にリダイレクトすること" do
        project_params = FactoryBot.attributes_for(
          :project,
          name: "Changed by Test!"
        )
        patch :update, params: {
          id: @project.id,
          project: project_params
        }
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end
end
