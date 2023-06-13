# frozen_string_literal: true

class System::TurboFrameComponent < ApplicationComponent
  option :id
  option :src, optional: true
  option :lazy, optional: true
  option :variant,
         default: proc { :spinner },
         type: Dry::Types['optional.symbol'].default(:spinner).enum(:spinner)
end
