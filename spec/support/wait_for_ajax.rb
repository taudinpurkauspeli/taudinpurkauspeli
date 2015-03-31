module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def click_and_wait(element_text)
    begin
      click_button(element_text)
      wait_for_ajax
      return
    rescue
    end

    begin
      click_link(element_text)
      wait_for_ajax
      return
    rescue
    end

    begin
      click_on(element_text)
      wait_for_ajax
      return
    rescue
    end

    raise "Element containing text '" + element_text + "' not found"
  end
end