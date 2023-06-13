# frozen_string_literal: true

class Layout::SidebarComponent < ApplicationComponent
  option :items
  option :bottom_items

  private

  def logo
    link_to root_path,
            class:
              'w-full p-2 aspect-square hover:animate-spin flex items-center bg-white/90 active:bg-white/80 rounded-full shadow' do
      helpers.image_tag url_for('logo_icon.png'), class: 'w-full'
    end
  end

  def sidebar_item(icon:, path:, label: nil, method: nil, hidden: false)
    if !hidden
      render(
        System::TooltipComponent.new(
          text: label,
          position: :right,
          hidden: hidden,
          body:
            link_to(
              helpers.fa_icon(icon, class: 'text-lg'),
              path,
              class: sidebar_item_class(path: path),
              method: method
            )
        )
      )
    end
  end

  def sidebar_item_class(path:)
    merge_classes(base_item_class, active_item_class(path: path))
  end

  def base_item_class
    'block cursor-pointer aspect-square rounded-lg p-3 flex flex-col justify-center items-center gap-1 py-1'
  end

  def active_item_class(path:)
    if current?(path)
      'bg-white/90 text-orange-400'
    else
      'text-white/90 active:bg-white/30 hover:bg-white/40'
    end
  end
end
