require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "Joe",
      last_name:  "Tester",
      email:      "joetester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
      )

    user.projects.create(
      name: "Test Project",
      )

    new_project = user.projects.build(
      name: "Test Project",
      )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows two users to share a project name" do
    user = User.create(
      first_name: "Joe",
      last_name:  "Tester",
      email:      "joetester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
      )

    user.projects.create(
      name: "Test Project",
      )

    other_user = User.create(
      first_name: "Jane",
      last_name:  "Tester",
      email:      "janetester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
      )

    other_project = other_user.projects.build(
      name: "Test Project",
      )

    expect(other_project).to be_valid
  end

  describe "遅延ステータス" do
    it "締切日が過ぎていれば遅延していること" do
      project = FactoryBot.create(:project_due_yesterday)
      expect(project).to be_late
    end

    it "締切日が今日ならスケジュール通りであること" do
      project = FactoryBot.create(:project_due_today)
      expect(project).to_not be_late
    end

    it "締切日が未来ならスケジュール通りであること" do
      project = FactoryBot.create(:project_due_tomorrow)
      expect(project).to_not be_late
    end

    fit "締切日が2日前なら遅延していること" do
      project = FactoryBot.create(:project, :due_2days_ago)
      expect(project).to be_late
    end
  end

end
