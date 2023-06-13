# frozen_string_literal: true

class System::Tabs::PaneComponent < ApplicationComponent
  option :padding,
         default: proc { :none },
         type:
           Dry::Types['optional.symbol']
             .default(:vertical)
             .enum(:vertical, :top, :bottom, :none, :all)

  private

  def container_class
    merge_classes(base_classes, padding_classes)
  end

  def base_classes; end

  def padding_classes
    {
      all: 'p-10',
      vertical: 'pt-20 pb-10',
      top: 'pt-20',
      bottom: 'pb-10',
      none: ''
    }[
      padding
    ]
  end
end
