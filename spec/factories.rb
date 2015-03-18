FactoryGirl.define do

  factory :user do
    username "Testipoika"
    realname "Teppo Testailija"
    email "teppo.testailija@gmail.com"
    password "Salainen1"
    password_confirmation "Salainen1"
    admin true
  end

  factory :student, class: User do
    username "Opiskelija"
    realname "Olli Testailija"
    email "teppo.testailija@gmail.com"
    password "Salainen1"
    password_confirmation "Salainen1"
    admin false
  end

  factory :exercise do
    name "Lihanautakuolemat"
    anamnesis "Kuolleita lehmiä: 15"
  end

  factory :task do
    name "Soita asiakkaalle"
    exercise_id 1
    level 1
  end

  factory :hypothesis do
    name "Virustauti"
    hypothesis_group_id 1
  end

  factory :banked_hypothesis, class: Hypothesis do
    name "Sorkkatauti"
    hypothesis_group_id 1
  end

  factory :exercise_hypothesis do
    exercise_id 1
    hypothesis_id 1
    task_id 1
    explanation "Anamneesin mukaan tauti on virustauti"
  end

  factory :hypothesis_group do
    name "Bakteeritaudit"
  end

  factory :completed_task do
    user_id 1
    task_id 1
  end

  factory :subtask do
    task_id 1
  end

  factory :task_text do
    subtask_id 1
    content "Lääkäri kertoo mikä on totuus"
  end

  factory :multichoice do
    subtask_id 1
    question "Tykkääkö koira nappuloista?"
  end
end
