# frozen_string_literal: true

class Layout::SidemenuComponent < ApplicationComponent
  option :items

  private

  def menu_item(label:, path:, icon:)
    link_to path, class: menu_item_classes(path: path) do
      concat helpers.fa_icon icon, class: 'w-[22px] mr-3 text-center'
      concat tag.div label
    end
  end

  def menu_item_classes(path:)
    merge_classes(
      menu_item_base_classes,
      menu_item_active_classes(path: path),
      menu_item_inactive_classes(path: path)
    )
  end

  def menu_item_base_classes
    'flex items-center block dark:hover:bg-gray-700 active:bg-white/30 text-sm py-2 px-2 hover:bg-white/20 rounded-xl'
  end

  def menu_item_inactive_classes(path:)
    'text-white/80' unless current?(path, strict: true)
  end

  def menu_item_active_classes(path:)
    'bg-white/20 text-white font-medium' if current?(path, strict: true)
  end
end
