# frozen_string_literal: true

class System::TooltipComponent < ApplicationComponent
  option :text, default: proc {}, type: Dry::Types['optional.string']
  option :body
  option :color,
         default: proc { :black },
         type:
           Dry::Types['optional.symbol']
             .default(:primary)
             .enum(:primary, :secondary, :success, :danger, :black)
  option :position,
         default: proc { :bottom },
         type:
           Dry::Types['optional.symbol']
             .default(:top)
             .enum(:top, :bottom, :right, :left)

  private

  def color_classes
    {
      primary: 'bg-orange-300 text-white',
      secondary: 'bg-slate-100 text-gray-800',
      success: 'bg-green-700 text-white',
      danger: 'bg-red-700 text-white',
      black: 'bg-black/90 text-white'
    }[
      color
    ]
  end
end
