FactoryGirl.define do


  factory :user do
    username "Testipoika"
    realname "Teppo Testailija"
    email "teppo.testailija@gmail.com"
    password "Salainen1"
    password_confirmation "Salainen1"
    admin true
  end


  factory :exercise do
    name "Lihanautakuolemat"
    anamnesis "Kuolleita lehmiä: 15"
  end

  factory :task do
    name "Soita asiakkaalle"
  end
 
  factory :hypothesis do
    name "Virustauti"
  end

  factory :exercise_hypothesis do
    exercise_id 1
    hypothesis_id 1
    end


end
