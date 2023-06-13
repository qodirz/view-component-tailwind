# frozen_string_literal: true

class System::ButtonComponent < ApplicationComponent
  option :form, default: proc {}, type: Dry::Types['optional.hash']
  option :data, default: proc {}, type: Dry::Types['optional.hash']
  option :label, default: proc {}, type: Dry::Types['optional.string']
  option :path, default: proc {}, type: Dry::Types['optional.string']
  option :rounded, default: proc { false }, type: Dry::Types['bool']
  option :text_center, default: proc {}
  option :block, default: proc { false }, type: Dry::Types['bool']
  option :target,
         default: proc {},
         type:
           Dry::Types['optional.symbol'].default(nil).enum(nil, :_top, :_blank)
  option :method,
         default: proc {},
         type:
           Dry::Types['optional.symbol']
             .default(nil)
             .enum(:get, :patch, :post, :delete, :put)
  option :variant,
         default: proc { :primary },
         type:
           Dry::Types['optional.symbol']
             .default(:primary)
             .enum(
               :primary,
               :secondary,
               :success,
               :danger,
               :chevron,
               :white,
               :transparent
             )
  option :as,
         default: proc { :link },
         type: Dry::Types['optional.symbol'].default(:link).enum(:link, :button)
  option :size,
         default: proc { :md },
         type:
           Dry::Types['optional.symbol'].default(:md).enum(:md, :lg, :sm, :xs)
  option :use_inline, default: proc { false }

  private

  def container(&block)
    return link_container(&block) if path

    default_container(&block)
  end

  def link_container(&block)
    if as == :link
      return(
        link_to(
          path,
          data: data,
          class: container_classes,
          style: container_styles,
          method: method,
          target: target,
          &block
        )
      )
    end
    if as == :button
      button_to(
        path,
        form: form,
        data: data,
        class: container_classes,
        style: container_styles,
        method: method,
        target: target,
        &block
      )
    end
  end

  def default_container(&block)
    tag.button(path, data: data, class: container_classes, &block)
  end

  def container_classes
    unless use_inline
      merge_classes(
        base_classes,
        rounded_classes,
        variant_classes,
        display_classes,
        text_center_classes,
        size_classes
      )
    end
  end

  def container_styles
    merge_styles(base_styles, variant_styles) if use_inline
  end

  def base_classes
    'cursor-pointer shadow border-t'
  end

  def base_styles
    'cursor: pointer; text-decoration: none; display: inline-block; padding: 8px 12px; border-radius: 8px;'
  end

  def rounded_classes
    rounded ? 'rounded-full' : 'rounded'
  end

  def variant_classes
    {
      primary: 'bg-primary hover:bg-orange-400 active:bg-orange-200 text-white',
      secondary:
        'bg-slate-100 hover:bg-slate-200 active:bg-slate-300 text-gray-800',
      success: 'bg-green-700 hover:bg-green-800 active:bg-green-900 text-white',
      danger: 'bg-red-400 hover:bg-red-500 active:bg-red-600 text-white',
      white: 'bg-white hover:bg-slate-50 active:bg-slate-100',
      chevron: 'border bg-white w-full hover:bg-gray-50 active:bg-gray-100',
      transparent:
        'shadow-none border-none text-gray-500 hover:bg-gray-50 active:bg-gray-100'
    }[
      variant
    ]
  end

  def variant_styles
    {
      primary: 'background-color: #fb923c; color: white;',
      secondary: 'background-color: #F1F5F9; color: #4c4c4c;',
      success: 'background-color: #16A34A; color: white;',
      danger: 'background-color: #EF4444; color: white;'
    }[
      variant
    ]
  end

  def display_classes
    block ? 'block w-full' : 'inline-block'
  end

  def size_classes
    {
      md: 'py-2 px-4 text-sm',
      lg: 'py-5 px-8 text-md',
      sm: 'py-1 px-3 text-sm',
      xs: 'py-1 px-3 text-xs'
    }[
      size
    ]
  end

  def text_center_classes
    should_center = text_center == true || (block and text_center.nil?)

    should_center ? 'text-center' : ''
  end

  def body_classes
    variant == :chevron ? 'flex items-center justify-between' : nil
  end

  def chevron_tag
    tag.div helpers.fa_icon('chevron-right'), class: 'pl-2 text-orange-400'
  end
end
