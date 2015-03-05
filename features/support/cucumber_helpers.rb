module CucumberHelpers

  def create_exercises
    Exercise.create name:"Lihanautakuolemat", anamnesis:"Lihanautoja on menehtynyt lukuisia"
    Exercise.create name:"Heikko hevonen", anamnesis:"Hevosella on heikot polvet"
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
    Task.create name:"Soita lääkärille", exercise_id:1
    Task.create name:"Lääkitse hevonen", exercise_id:2
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

  def go_to_case(exercise)
    visit exercises_path
    click_button(exercise)
  end





end

#Add helper methods to World --> you will be able to use them in cucumber steps

World(CucumberHelpers)
