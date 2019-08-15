require 'rails_helper'

RSpec.describe SavedExercise, type: :model do


  it "has fields set correctly" do
    saved_exercise = SavedExercise.new exercise_id:1, user_id:1, completion_percent:100, description:"Suoritti casen"

    expect(saved_exercise.exercise_id).to eq(1)
    expect(saved_exercise.user_id).to eq(1)
    expect(saved_exercise.completion_percent).to eq(100)
    expect(saved_exercise.description).to eq("Suoritti casen")

  end


end
