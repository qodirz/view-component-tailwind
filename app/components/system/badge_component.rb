# frozen_string_literal: true

class System::BadgeComponent < ApplicationComponent
  option :body, default: proc {}, type: Dry::Types['optional.string']
  option :border_color,
         default: proc {},
         type:
           Dry::Types['optional.symbol']
             .default(:secondary)
             .enum(:primary, :secondary, :success, :danger, :dark)
  option :color,
         default: proc { :secondary },
         type:
           Dry::Types['optional.symbol']
             .default(:secondary)
             .enum(:primary, :secondary, :success, :danger, :dark)
  option :size,
         default: proc { :xs },
         type:
           Dry::Types['optional.symbol'].default(:md).enum(:xs, :sm, :md, :lg)
  option :use_inline, default: proc { false }

  private

  def container(&block)
    body_classes(&block)
  end

  def body_classes
    merge_classes(
      base_classes,
      size_classes,
      colors_classes,
      border_colors_classes
    )
  end

  def body_styles
    merge_styles(base_styles, colors_styles) if use_inline
  end

  def base_classes
    'py-2 px-3 rounded-lg inline-block font-medium select-none'
  end

  def base_styles
    'padding: 6px; border-radius: 6px; display: inline; font-weight: 500;'
  end

  def size_classes
    # text-xs text-lg text-md text-lg
    "text-#{size}"
  end

  def colors_classes
    {
      primary: 'bg-orange-300 text-white',
      secondary: 'bg-slate-100 text-gray-800',
      success: 'text-green-800 bg-green-200 ',
      danger: 'bg-red-200  text-red-700',
      dark: 'bg-gray-400 text-white'
    }[
      color
    ]
  end

  def colors_styles
    {
      primary: 'background-color: #fb923c; color: white;',
      secondary: 'background-color: #F1F5F9; color: #4c4c4c;',
      success: 'background-color: #16A34A; color: white;',
      danger: 'background-color: #EF4444; color: white;'
    }[
      color
    ]
  end

  def border_colors_classes
    {
      primary: 'border border-orange-400',
      secondary: 'border border-slate-200',
      success: 'border border-green-700',
      danger: 'border border-red-400',
      dark: 'border border-gray-300'
    }[
      border_color
    ]
  end
end
