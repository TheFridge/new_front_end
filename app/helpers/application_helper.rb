module ApplicationHelper
  def active_tab
    actions = ['recipe','shopping_list', 'cupboard','favorites']
    actions.each_with_object({}) do |action, hash|
     hash[action] = "active" if current_page?(action: action)
    end
  end
end
