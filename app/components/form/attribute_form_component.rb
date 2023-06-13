# frozen_string_literal: true

class Form::AttributeFormComponent < ApplicationComponent
  option :form
  option :items
  option :cols,
         default: proc { 4 },
         type: Dry::Types['optional.integer'].default(4).enum(1, 2, 3, 4, 5, 6)

  private

  def container_classes
    "grid grid-cols-#{[(items.count - hidden_items), cols].min} gap-4 "
  end

  def item_label_classes
    'text-sm text-gray-500 font-medium mb-4'
  end

  def wrapper_classes_for(item)
    merge_classes(item[:wrapper_class], grid_cols_class_for(item))
  end

  def input_html_class_for(_item)
    'border-none shadow-none bg-slate-50 focus:bg-white hover:bg-slate-100'
  end

  def grid_cols_class_for(item)
    # ? Need for tailwind to compile
    # ? col-span-1 col-span-2 col-span-3 col-span-4 col-span-5 col-span-6
    "col-span-#{item[:cols]}" if item[:cols]
  end

  def hidden_items
    items.select { |item| item[:as] == :hidden }.count
  end

  def input(form, item)
    form.input item[:input],
               label: item[:label],
               as: item[:as],
               hint: item[:hint],
               default: item[:default],
               disabled: item[:disabled],
               label_html: { class: item[:as] == :select ? 'block p-0 mb-2' : '' },
               collection: item[:collection],
               input_html: { **item.fetch(:input_html, {}), class: input_html_class_for(item) },
               include_blank: item[:include_blank],
               selected: item[:selected]
  end
end
