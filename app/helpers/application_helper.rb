module ApplicationHelper

  def active?(controller, action)
    if [params[:controller], params[:action]] == [controller, action]
      "active"
    end
  end

end
