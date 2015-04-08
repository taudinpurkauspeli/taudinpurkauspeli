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
    exercise_id nil
    level 1
  end

  factory :task_with_long_name, class: Task do
    name "Hoida"
    exercise_id nil
    level 1
  end

  factory :task_with_short_name, class: Task do
    name "Soita jokaiselle mahdolliselle lääkärille ja asiakkaalle jonka tunnet"
    exercise_id nil
    level 1
  end

  factory :hypothesis do
    name "Virustauti"
    hypothesis_group_id nil
  end

  factory :banked_hypothesis, class: Hypothesis do
    name "Sorkkatauti"
    hypothesis_group_id nil
  end

  factory :exercise_hypothesis do
    exercise_id nil
    hypothesis_id nil
    task_id nil
    explanation "Anamneesin mukaan tauti on virustauti"
  end

  factory :hypothesis_group do
    name "Bakteeritaudit"
  end

  factory :completed_task do
    user_id nil
    task_id nil
  end

  factory :subtask do
    task_id nil
  end

  factory :task_text do
    subtask_id nil
    content "Lääkäri kertoo mikä on totuus"
  end

  factory :multichoice do
    subtask_id nil
    question "Tykkääkö koira nappuloista?"
  end

  factory :radiobutton, class: Multichoice do
    subtask_id nil
    question "Kenelle pitää soittaa?"
    is_radio_button true
  end

  factory :option do
    multichoice_id nil
    content "Tykkää"
    explanation "Juuri oikea vastaus"
    is_correct_answer true
  end

  factory :question do
    question_group_id nil
    title "Oliko lehmällä veljiä?"
    content "Asiakas vastaa, että lehmällä ei ollut veljiä."
    required true
  end

  factory :question_group do
    title "Lehmätaudit"
  end

  factory :interview do
    subtask_id nil
    title "Omistajan haastattelu"
  end
end
