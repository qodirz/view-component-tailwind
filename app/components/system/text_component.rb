class System::TextComponent < ApplicationComponent
  option :tag,
         default: proc { :p },
         type:
           Dry::Types['optional.symbol']
             .default(:p)
             .enum(:h1, :h2, :h3, :h4, :h5, :span, :p, :small, :b, :i)
  option :color,
         default: proc { :default },
         type:
           Dry::Types['optional.symbol']
             .default(:default)
             .enum(
               :default,
               :primary,
               :secondary,
               :success,
               :danger,
               :muted,
               :dark,
               :white
             )
  option :body, default: proc {}
  option :block, default: proc { false }
  option :use_inline, default: proc { false }

  private

  def container_tag(&block)
    content_tag(tag, class: container_classes, style: container_styles, &block)
  end

  def container_classes
    merge_classes(color_classes, tag_classes, block_classes) unless use_inline
  end

  def container_styles
    merge_styles(color_styles, tag_styles) if use_inline
  end

  def color_classes
    {
      default: 'text-slate-600',
      primary: 'text-orange-400',
      secondary: 'text-slate-400',
      success: 'text-green-600',
      danger: 'text-red-500',
      muted: 'text-slate-300',
      dark: 'text-black',
      white: 'text-white'
    }[
      color
    ]
  end

  def tag_classes
    {
      h1: 'text-4xl font-semibold',
      h2: 'text-3xl font-semibold',
      h3: 'text-2xl font-semibold',
      h4: 'text-xl font-semibold',
      h5: 'text-lg font-semibold',
      span: '',
      p: 'block',
      i: '',
      small: '',
      b: 'font-medium'
    }[
      tag
    ]
  end

  def color_styles
    {
      default: 'color: #475569;',
      primary: 'color: #fb923c;',
      secondary: 'color: #94A3B8;',
      success: 'color: #16A34A;',
      danger: 'color: #EF4444;',
      muted: 'color: #CBD5E1;'
    }[
      color
    ]
  end

  def tag_styles
    {
      h1: '',
      h2: '',
      h3: '',
      h4: '',
      h5: '',
      span: '',
      p: '',
      i: '',
      small: '',
      b: ''
    }[
      tag
    ]
  end

  def block_classes
    'block' if block
  end
end
