# frozen_string_literal: true

class Layout::BreadcrumbsComponent < ApplicationComponent
  option :items, default: proc { [] }, type: []
  option :account_name, optional: true

  private

  def container_classes
    'flex items-center text-sm'
  end

  def crumb(item)
    return link_crumb(item) if item.path.present?

    basic_crumb(item)
  end

  def link_crumb(item)
    link_to item.label, item.path, class: crumb_classes(item)
  end

  def basic_crumb(item)
    tag.div item.label, class: crumb_classes(item)
  end

  def crumb_classes(item)
    merge_classes(crumb_base_classes, crumb_active_classes(item))
  end

  def crumb_base_classes
    'px-2 py-1 rounded-lg cursor-pointer'
  end

  def crumb_active_classes(item)
    if item.path.present?
      'text-gray-400
      font-medium
      hover:text-primary hover:bg-gray-100
      active:text-primary active:bg-gray-200
      '
    else
      '
        bg-gray-100
        text-primary
        font-medium
      '
    end
  end

  def divider_classes
    'px-2 text-[.7rem] text-gray-300'
  end
end
