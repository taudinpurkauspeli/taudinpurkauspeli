module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def click_and_wait(element_text)

    begin
      click_link_or_button(element_text)
      wait_for_ajax
      return
    rescue
      # puts "Clickable thing '" + element_text + "' not found"
    end

    begin
      click_button(element_text)
      wait_for_ajax
      return
    rescue
      # puts "Button '" + element_text + "' not found"
    end

    begin
      click_link(element_text)
      wait_for_ajax
      return
    rescue
      # puts "Link '" + element_text + "' not found"
    end

    begin
      click_on(element_text)
      wait_for_ajax
      return
    rescue
      # puts "Clickable thing '" + element_text + "' not found"
    end

    raise "Element containing text '" + element_text + "' not found"
  end

  def wait_and_trigger_click(element)

    begin
      find_button(element).trigger('click')
      wait_for_ajax
      return
    rescue
      # puts "Button '" + element + "' not found in DOM"
    end

    begin
      find_link(element).trigger('click')
      wait_for_ajax
      return
    rescue
      # puts "Link '" + element + "' not found in DOM"
    end

    begin
      click_link_or_button(element)
      wait_for_ajax
      return
    rescue
      # puts "Clickable thing '" + element_text + "' not found"
    end

    raise "Element containing text '" + element + "' not found in DOM"
  end

end