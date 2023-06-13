class ApplicationComponent < ViewComponent::Base
  extend Dry::Initializer

  private

  def current?(path, strict: false)
    req = helpers.request.original_fullpath

    return false if (path == '/') && (req != '/')

    return helpers.request.original_fullpath.split('?').first == path if strict

    helpers.request.original_fullpath[0...path.length] == path
  end

  def merge_classes(*classes)
    classes.reduce('') do |prev, curr|
      next prev if curr.nil?

      prev << "#{prev.empty? ? '' : ' '}#{curr.strip}"

      prev
    end
  end

  def merge_styles(*styles)
    styles.reduce('') do |prev, curr|
      next prev if curr.nil?

      prev << "#{prev.empty? ? '' : ' '}#{curr.strip}"

      prev
    end
  end

  def l(*args)
    helpers.l(*args)
  end

  def humanize_sentence(text)
    return if text.nil?

    arr = []
    text.split.each_with_index do |word, index|
      arr << (index == 0 ? word.titleize : word.humanize.downcase)
    end
    arr.join(' ')
  end

  def icon_for(icon, options = {})
    color = options.fetch(:color, nil)

    "<i class=\"fas fa-#{icon} #{color ? "text-#{color}" : ''} \"></i>"
      .html_safe
  end
end
