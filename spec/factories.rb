FactoryGirl.define do 
  factory :user do 
    sequence :email do |n| 
      "person#{n}@example.com" 
    end
    sequence :name  do |n| 
      "Bob #{n}" 
    end
    password "foobar11"
    password_confirmation "foobar11"
    admin false

    factory :admin do 
      admin true
    end
  end

  factory :question do 
    title "This is the title of my question"
    content "This is my question"
    user
  end

  factory :answer do 
    content "This is the answer"
    user 
    question
  end
end
