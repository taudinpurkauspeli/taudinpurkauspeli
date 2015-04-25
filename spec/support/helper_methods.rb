module HelperMethods

  def sign_in(credentials)
    visit exercises_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Kirjaudu sisään')
    wait_for_ajax
  end

  def number_of_ex_tasks
    return exercise.tasks.where(level:1...999).count
  end

  def get_task_count
    return Task.where(level:1...999).count
  end

  def current_user
    user = instance_double("User", :username => "Testi", :realname => "Pekka", :password => "Salasana1", :password_confirmation => "Salasana1", :email => "pekka@pera.com")

    return user
  end

  def populate_task(task)
    subs = Array.new(10)
    for i in 0...10
      subs[i] = Subtask.create task:task
    end
    return subs
  end

  def populate_user_with_subtasks(user, array)
    for i in 0...3
      user.completed_subtasks.create(subtask:array[i])
    end
  end

end