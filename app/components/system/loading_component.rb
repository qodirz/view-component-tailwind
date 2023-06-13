# frozen_string_literal: true

class System::LoadingComponent < ApplicationComponent
  option :variant,
         default: proc { :spinner },
         type:
           Dry::Types['optional.symbol']
             .default(:spinner)
             .enum(:spinner, :grow)

  private

  def container_classes
    'flex justify-center items-center'
  end

  def loading_classes
    merge_classes(base_classes, send("#{variant}_classes"))
  end

  def base_classes
    'rounded-full h-8 w-8 border-4 border-orange-100'
  end

  def spinner_classes
    'animate-spin border-r-orange-400'
  end

  def grow_classes
    'spinner-grow bg-orange-400 opacity-0'
  end
end
