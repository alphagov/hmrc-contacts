# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:question_title) { |n| "question title #{n}" }

  factory :question do
    contact
    contact_group

    title { generate(:question_title) }
  end
end
