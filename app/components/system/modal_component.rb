# frozen_string_literal: true

class System::ModalComponent < ApplicationComponent
  option :title
  option :width, default: proc { 'w-[650px]' }
  renders_one :footer

  def call
    helpers.turbo_frame_tag 'modal' do
      container
    end
  end

  def container
    tag.div modal,
            data: {
              controller: :modal,
              action:
                'turbo:submit-end->modal#submitEnd keyup@window->modal#closeWithKeyboard click@window->modal#closeBackground'
            },
            style: 'z-index:999',
            class:
              'bg-gray-500/50 top-0 left-0 right-0 absolute w-full h-full overflow-y-auto z-10 break-words mx-auto center pt-4'
  end

  def modal
    tag.div class: "bg-white mx-auto shadow rounded-2xl #{width} py-4",
            data: {
              'modal-target': :modal
            } do
      concat modal_header
      concat modal_body
      concat modal_footer if footer
    end
  end

  def modal_header
    tag.div do
      concat tag.div tag.span(title) +
                     render(
                       System::ButtonComponent.new(
                         label: helpers.fa_icon(:times),
                         variant: :primary,
                         size: :sm,
                         tag: :b,
                         rounded: true,
                         data: {
                           action: 'click->modal#hideModal'
                         }
                       )
                     ),
                     id: 'modal-header',
                     class:
                       'pb-4 pt-1 px-6 text-xl border-b font-semibold sticky top-0 bg-white flex justify-between items-center'
    end
  end

  def modal_body
    tag.div content, class: 'px-6 py-6'
  end

  def footer_body
    footer
  end
end
