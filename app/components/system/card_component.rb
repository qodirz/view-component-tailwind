# frozen_string_literal: true

class System::CardComponent < ApplicationComponent
  option :padding,
         default: proc { :all },
         type:
           Dry::Types['optional.symbol']
             .default(:all)
             .enum(:all, :vertical, :horizontal, :none)
  option :padding_size,
         default: proc { 6 },
         type: Dry::Types['optional.integer']
  option :use_inline, default: proc { false }

  private

  def card_classes
    merge_classes(base_classes, padding_classes) unless use_inline
  end

  def base_classes
    'border rounded-lg bg-white mb-10'
  end

  def card_styles
    if use_inline
      'border: 1px solid rgba(229,231,235,1); border-radius: 12px; background-color: white; margin-bottom: 64px; padding: 16px;'
    end
  end

  def padding_classes
    case padding
    when :all
      "p-#{padding_size}"
    when :vertical
      "py-#{padding_size}"
    when :horizontal
      "px-#{padding_size}"
    when :none
      'p-0'
    end
  end
end
