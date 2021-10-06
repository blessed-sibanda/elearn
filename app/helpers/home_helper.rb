module HomeHelper
  def metric(count:, item:, color: "primary")
    item.capitalize!
    unless count == 1
      item = item.pluralize
    end
    render partial: "home/metric",
           locals: { count: count, item: item, color: "is-#{color}" }
  end
end
