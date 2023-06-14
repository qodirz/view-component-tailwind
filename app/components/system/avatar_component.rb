# frozen_string_literal: true

class System::AvatarComponent < ApplicationComponent
  option :url, default: proc {}, type: Dry::Types['optional.string']
  option :size,
         default: proc { :md },
         type: Dry::Types['optional.symbol'].default(:md).enum(:sm, :md, :lg)

  private

  def image_classes
    merge_classes(base_classes, size_classes)
  end

  def base_classes
    'bg-slate-300 rounded-full border border-2 bg-cover'
  end

  def size_classes
    {
      sm: 'w-[28px] h-[28px]',
      md: 'w-[60px] h-[60px]',
      lg: 'w-[110px] h-[110px]'
    }[
      size
    ]
  end
end
