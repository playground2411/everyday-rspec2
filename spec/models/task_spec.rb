require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { FactoryBot.create(:project) }

  it "プロジェクトと名前があれば有効" do
    task = Task.new(
      project: project,
      name: "new task"
    )
    expect(task).to be_valid
  end

  it "プロジェクトがなければ無効" do
    task = Task.new(project: nil)
    task.valid?
    expect(task.errors[:project]).to include("must exist")
  end

  it "名前がなければ無効" do
    task = Task.new(
      project: project,
      name: nil
    )
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end
end
