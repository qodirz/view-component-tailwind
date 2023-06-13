# frozen_string_literal: true

class System::TableComponent < ApplicationComponent
  option :items, default: proc { [] }
  option :columns, default: proc { [] }, type: []
  option :row, default: proc {}
  option :q, default: proc {}
  option :padding_size, default: proc { :default }
  option :font_weight, default: proc { :medium }
  option :whitespace, default: proc { :nowrap }
  option :scroll, default: proc { true }
  option :to, default: proc {}
  option :use_inline, default: proc { false }

  private

  def visible_columns
    columns.reject { |c| c&.dig(:hidden) }
  end

  def row_for(_row, _columns, item)
    tag.tr class: tr_classes, data: row_data do
      visible_columns.each do |column|
        concat content_tag :td,
                           cell_for(column, item),
                           class: tag_classes,
                           style: tag_styles
      end
      concat link_item(item) if to.present?
    end
  end

  def link_item(item)
    content_tag :td, class: tag_classes do
      link_to to[:path].call(item), data: to[:data], class: 'text-right' do
        tag.div render(
          System::ButtonComponent.new(
            label: helpers.fa_icon('chevron-right'),
            variant: :secondary
          )
        )
      end
    end
  end

  def cell_for(column, item)
    return column[:render].call(item) if column[:render].present?
    return nil unless column[:accessor]

    value = value_for(item.send(column[:accessor]))

    render System::TextComponent.new body: value if value
  end

  def value_for(value)
    case value.class.name
    when 'DateTime', 'Date', 'Time'
      return nil if !value

      return l(value)
    when 'Array'
      return value.to_sentence
    else
      value
    end
  end

  def row_data
    if row
      row[:data]&.call(item)
    end
  end

  def container_classes
    merge_classes('w-full', scroll_classes)
  end

  def scroll_classes
    'overflow-x-auto' if scroll
  end

  def table_classes
    'w-full'
  end

  def table_styles
    'width: 100%;'
  end

  def th_classes
    merge_classes(
      'text-left border-b  cursor-default dark:text-gray-300 text-slate-400 border-gray-100',
      nospace_classes,
      padding_th_classes
    )
  end

  def th_styles
    if use_inline
      'text-align: left; color: #475569; font-weight: 600; border: 1px solid rgba(229,231,235,1); padding: 1rem'
    end
  end

  def padding_th_classes
    return 'pr-6 pb-4' if padding_size == :default
    return 'pr-4 pb-2' if padding_size == :sm
  end

  def tag_classes
    merge_classes(
      'text-sm medium border-slate-100',
      padding_tags,
      font_weight_classes,
      nospace_classes
    )
  end

  def tag_styles
    if use_inline
      'padding: 1rem; color: #475569; border: 1px solid rgba(229,231,235,1)'
    end
  end

  def nospace_classes
    return 'whitespace-nowrap' if whitespace == :nowrap
  end

  def font_weight_classes
    return 'font-medium' if font_weight == :medium
  end

  def padding_tags
    return 'py-6 pr-6' if padding_size == :default
    return 'py-2 pr-4' if padding_size == :sm
  end

  def tr_classes
    'border-b border-gray-100 text-gray-700'
  end
end
