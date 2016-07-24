module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: 'alert-success', error: 'alert-danger', notice: 'alert-warning'}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    # flash.map do |msg_type, message|
    #   content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in pad-top-80") do
    #     content_tag(:button, 'x'.html_safe, class: 'close', data: {dismiss: 'alert'}) + message
    #   end
    # end.join.html_safe
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'success'
      type = 'error'   if type == 'error'
      type = 'warning'   if type == 'notice'
      text = "<script>toastr.options = {'closeButton': true}; toastr.#{type}(\"#{message}\");</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def format_currency(price)
    number_to_currency(price, precision: 0, unit: "VND", delimiter: ",", format: "%n %u")
  end
end
