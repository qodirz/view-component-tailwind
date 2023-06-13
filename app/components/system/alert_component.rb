# frozen_string_literal: true

class System::AlertComponent < ApplicationComponent
  option :body
  option :variant,
         default: proc { :notice },
         type:
           Dry::Types['optional.symbol']
             .default(:notice)
             .enum(:notice, :alert, :error)
  option :inline, default: proc { false }, type: Dry::Types['bool']
  option :size,
         optional: true,
         type: Dry::Types['optional.symbol'].default(nil).enum(:sm)

  def container_classes
    merge_classes(
      base_classes,
      send("#{variant}_classes"),
      display_classes,
      text_size_classes
    )
  end

  def base_classes
    'py-2 px-3 mb-5 font-medium rounded-lg '
  end

  def display_classes
    inline ? 'inline-block' : 'block'
  end

  def notice_classes
    'bg-green-100 text-green-500'
  end

  def alert_classes
    'bg-yellow-100 text-yellow-600'
  end

  def error_classes
    'bg-red-100 text-red-500'
  end

  def text_size_classes
    return 'text-sm' if size == :sm
  end
end
