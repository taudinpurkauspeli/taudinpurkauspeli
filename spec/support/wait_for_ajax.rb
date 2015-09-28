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

    raise "Element containing text '" + element + "' not found in DOM"
  end

  def wait_for_ckeditor(selector)
    Timeout.timeout(30) do
      loop until page.evaluate_script("isCkeditorLoaded('#{selector}');")
    end
  end

  def fill_in_ckeditor(selector, html)
    wait_for_ckeditor(selector)

    html[:with].gsub!(/\n+/, "") # otherwise: unterminated string literal (Selenium::WebDriver::Error::JavascriptError)
    page.execute_script("CKEDITOR.instances['#{selector}'].setData('#{html[:with]}');")
  end
end