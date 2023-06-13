# frozen_string_literal: true

class System::FilterFormComponent < ApplicationComponent
  option :q
  option :inputs

  private

  def form
    helpers.autosubmit_filter_form_for q, url: request.original_url do |f|
      tag.div class: 'pb-12 flex items-start' do
        inputs.map do |filter|
          if filter[:select]
            concat f.input filter[:value], collection: filter[:collection], label: filter[:label], input_html: { multiple: filter[:select][:multiple] || false }, wrapper_html: { class: 'ml-2 w-3/12' }
          else
            concat f.search_field filter[:value], class: 'input-input ml-2 w-3/12 mt-5', placeholder: filter[:label].titleize
          end
        end
      end
    end
  end
end
