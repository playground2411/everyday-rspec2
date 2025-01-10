FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "project #{n}" }
    description { "A test project." }
    due_on { 1.week.from_now }
    association :owner
  end

  factory :project_due_yesterday, class: Project do
    sequence(:name) { |n| "Test project #{n}" }
    description { "A test project." }
    due_on { 1.day.ago }
    association :owner
  end

  factory :project_due_today, class: Project do
    sequence(:name) { |n| "Test project #{n}" }
    description { "A test project." }
    due_on { Date.current.in_time_zone }
    association :owner
  end

  factory :project_due_tomorrow, class: Project do
    sequence(:name) { |n| "Test project #{n}" }
    description { "A test project." }
    due_on { 1.day.from_now }
    association :owner
  end
end
