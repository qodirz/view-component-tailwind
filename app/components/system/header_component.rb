# frozen_string_literal: true

class System::HeaderComponent < ApplicationComponent
  option :title, default: proc {}
  option :actions, default: proc { [] }
  option :sticky, default: proc { true }

  private

  def container_classes
    return base_container_classes unless sticky

    "#{base_container_classes} #{sticky_container_classes}"
  end

  def base_container_classes
    'bg-white mb-6'
  end

  def sticky_container_classes
    'sticky top-0 z-10 border-b border-gray-100'
  end

  def header_container_classes
    'flex justify-between h-[68.8px] mt-6 items-center'
  end

  def title_classes
    'text-2xl font-semibold dark:text-white text-gray-600'
  end

  def content_classes
    'pt-6 pb-4'
  end
end
