# frozen_string_literal: true

class LogoComponent < ApplicationComponent
  option :variant, default: proc {}, type: Dry::Types['optional.symbol']
end
