# frozen_string_literal: true

class System::AttributesComponent < ApplicationComponent
  option :items
  option :cols,
         default: proc { 4 },
         type:
           Dry::Types['optional.integer'].default(4).enum(1, 2, 3, 4, 5, 6, 8)

  def call
    tag.div class: container_classes do
      items.each { |item| concat(attribute(item)) unless item[:hidden] == true }
    end
  end

  private

  def attribute(item)
    tag.div do
      concat tag.div item[:label], class: item_label_classes
      concat tag.div item[:value]
    end
  end

  def grid_options
    # need this for tailwind to compile
    'grid-cols-1 grid-cols-2 grid-cols-3 grid-cols-4 grid-cols-5 grid-cols-6 grod-cols-8'
  end

  def container_classes
    "grid grid-cols-#{cols} gap-4 "
  end

  def item_label_classes
    'block text-slate-400 mb-1'
  end
end
