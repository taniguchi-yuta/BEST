module DeviseHelper
  def bootstrap_alert(key)
    case key
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end
end