FactoryGirl.define do


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
