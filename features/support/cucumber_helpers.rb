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
    Task.create name:"Soita lääkärille"
    Task.create name:"Lääkitse hevonen"
  end

  def add_hypothesis_to_case(ids)

    ExerciseHypothesis.create exercise_id:ids[:exercise_id], hypothesis_id:ids[:hypothesis_id]

  end





end

#Add helper methods to World --> you will be able to use them in cucumber steps

World(CucumberHelpers)
