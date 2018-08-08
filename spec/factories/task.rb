FactoryBot.define do
  factory :task do
    title "Task Title"
    description "Task description"
    status :pending
    association :project, factory: :project
    # association :user, factory: :user
  end
end
