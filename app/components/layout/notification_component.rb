# frozen_string_literal: true

class Layout::NotificationComponent < ApplicationComponent
  option :data, default: proc {}, type: Dry::Types['optional.hash']
  option :title, default: proc {}, type: Dry::Types['optional.string']
  option :body, default: proc {}, type: Dry::Types['optional.string']

  def call
    tag.div class: container_classes, data: data do
      concat tag.div text
    end
  end

  private

  def text
    tag.div do
      concat tag.b title if title
      concat tag.div body if body
    end
  end

  def container_classes
    '
      w-full p-1 center bg-green-600 text-white text-sm flex justify-center items-center top-0 left-0
    '
  end
end
