# frozen_string_literal: true

class System::Tabs::BarComponent < ApplicationComponent
  option :items, default: proc { [] }, type: []

  private

  def tab(item)
    link_to item.label, item.path, class: tab_container_classes(item)
  end

  def visible_items
    items.filter { |item| !item[:hidden] }
  end

  def tab_container_classes(item)
    merge_classes(base_classes, current_classes(item))
  end

  def base_classes
    'text-center whitespace-nowrap pt-4 pb-4 hover:text-gray-600 active:text-gray-700 rounded-t-xl font-medium text-sm text-gray-500'
  end

  def current_classes(item)
    if current?(item.path, strict: true)
      'border-b-4 border-primary font-semibold text-gray-600'
    end
  end
end
