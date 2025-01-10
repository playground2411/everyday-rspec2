FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "project #{n}" }
    description { "A test project." }
    due_on { 1.week.from_now }
    association :owner

    factory :project_due_yesterday do
      due_on { 1.day.ago }
    end

    factory :project_due_today do
      due_on { Date.current.in_time_zone }
    end

    factory :project_due_tomorrow do
      due_on { 1.day.from_now }
    end

    trait :due_2days_ago do
      due_on { 2.day.ago }
    end

    # メモ月のプロジェクト
    trait :with_notes do
      after(:create) { |project| create_list(:note, 5, project: project) }
    end
  end
end
