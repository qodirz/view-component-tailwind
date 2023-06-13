# frozen_string_literal: true

class System::ModelTableComponent < ApplicationComponent
  option :columns, default: proc { [] }, type: []
  option :items, default: proc { [] }, type: []
end
