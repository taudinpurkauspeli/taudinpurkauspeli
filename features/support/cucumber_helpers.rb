module CucumberHelpers

  def create_exercises
    FactoryGirl.create(:exercise, name:"Lihanautakuolemat", anamnesis:"Lihanautoja on menehtynyt lukuisia")
    FactoryGirl.create(:exercise, name:"Heikko hevonen", anamnesis:"Hevosella on heikot polvet")
  end

  def create_students
    FactoryGirl.create(:student)
    FactoryGirl.create(:student, username: "Heppo", first_name: "Heppo", last_name: "Kepponen", student_number: "123456789")
    FactoryGirl.create(:student, username: "Teppo", first_name: "Teppo", last_name: "Hepponen", student_number: "987654321")
  end

  def create_hypothesis_groups
    HypothesisGroup.create name:"Nautataudit"
    HypothesisGroup.create name:"Hevostaudit"
  end

  def create_hypotheses
    Hypothesis.create name:"Nautaflunssa", hypothesis_group_id:1
    Hypothesis.create name:"Hevosheikkous", hypothesis_group_id:2
  end

  def create_tasks
    Task.create name:"Soita lääkärille", exercise_id:1, level:1
    Task.create name:"Lääkitse hevonen", exercise_id:1, level:1
    Task.create name:"Lääkitse koira", exercise_id:2, level:1
  end

  def create_task_texts
    FactoryGirl.create(:subtask, task_id:3)
    FactoryGirl.create(:task_text, subtask_id: 1)

    FactoryGirl.create(:subtask, task_id: 4)
    FactoryGirl.create(:task_text, subtask_id: 2, content:"Lääkitään")
  end

  def create_multichoices
    FactoryGirl.create(:subtask, task_id:3)
    FactoryGirl.create(:multichoice, subtask_id:1)

    FactoryGirl.create(:subtask, task_id: 4)
    FactoryGirl.create(:multichoice, subtask_id: 2, question:"Mitä lääkkeitä käytät?")
    FactoryGirl.create(:option, multichoice_id: 2, content: "Bakteerilääke")
    FactoryGirl.create(:option, multichoice_id: 2, content: "Astmalääke", is_correct_answer: "wrong", explanation: "Ei oikea vastaus")
    FactoryGirl.create(:option, multichoice_id: 2, content: "Superbakteerilääke", explanation: "Toinen oikea vastaus")
    FactoryGirl.create(:option, multichoice_id: 2, content: "Kurkkulääke", is_correct_answer: "allowed", explanation: "Melkein oikea vastaus")
  end

  def create_radiobuttons
    FactoryGirl.create(:subtask, task_id:3)
    FactoryGirl.create(:radiobutton, subtask_id:1)

    FactoryGirl.create(:subtask, task_id: 4)
    FactoryGirl.create(:radiobutton, subtask_id: 2, question:"Mitä lääkettä käytät?")
    FactoryGirl.create(:option, multichoice_id: 2, content: "Bakteerilääke", is_correct_answer: "allowed", explanation: "Melkein oikein")
    FactoryGirl.create(:option, multichoice_id: 2, content: "Astmalääke", is_correct_answer: "wrong", explanation: "Ei oikea vastaus")
    FactoryGirl.create(:option, multichoice_id: 2, content: "Kurkkulääke", explanation: "Oikea vastaus")
  end

  def create_interviews
    FactoryGirl.create(:subtask, task_id:3)
    FactoryGirl.create(:interview, subtask_id:1, title:"Haastattelu")

    FactoryGirl.create(:subtask, task_id: 4)
    FactoryGirl.create(:interview, subtask_id: 2, title:"Mitä kysyt asiakkaalta?")
    FactoryGirl.create(:question, interview_id: 2, title: "Sääolosuhteet", content: "Paljon ukkosta")
    FactoryGirl.create(:question, interview_id: 2, title: "Sisäolosuhteet", required: "wrong", content: "Kaikki hyvin")
    FactoryGirl.create(:question, interview_id: 2, title: "Ulko-olosuhteet", content: "Epämääräistä")
    FactoryGirl.create(:question, interview_id: 2, title: "Karsinaolosuhteet", required: "allowed", content: "Lattia puhdas")
  end

  def create_all_hypotheses_for_case
    create_exercises
    create_hypothesis_groups
    create_hypotheses
  end

  def createSomeHypotheses
    Hypothesis.create name:"Nautaflunssa", hypothesis_group_id:1, id:1
    Hypothesis.create name:"Sikatartunta", hypothesis_group_id:1, id:2
    Hypothesis.create name:"Aivokuume", hypothesis_group_id:1, id:3
  end

  def add_hypothesis_to_case(fields)
    ExerciseHypothesis.create exercise_id:fields[:exercise_id], hypothesis_id:fields[:hypothesis_id], explanation:fields[:explanation], task_id:fields[:task_id]
  end

  def complete_task(task, user)
    CompletedTask.create user:user, task:task
  end

  def complete_subtask(subtask, user)
    CompletedSubtask.create user:user, subtask:subtask
  end

  def go_to_case(exercise)
    visit exercises_path
    click_button(exercise)
    wait_for_ajax
  end

end

#Add helper methods to World --> you will be able to use them in cucumber steps

World(CucumberHelpers)
