module Architects::ScreensHelper
  def annotation_style(cfg)
    cfg.inject("") do |memo, key|
      setting,value = key
      memo << "#{ setting }:#{ value };"
    end
  end

  def format_response_headers hash, options={}
    example = options[:example]

    hash.inject("HTTP Status #{ example.response_status }\n") do |memo,pair|
      header, value = pair
      memo << "#{ header }= #{ value }\n"
    end
  end

  def format_response object, options={}
    return JSON.pretty_generate(object) if object.is_a?(Array) || object.is_a?(Hash)
    object.to_s
  end

  def screen_has_details? screen
    (!screen.annotations.empty? || !screen.acceptance_criteria.empty? || !screen.data_sources.empty?)
  end

  def screen_image_path(image)
    path = Architects.configuration.images_path
    [path,asset_path(image)].compact.join("/")
  end

  def link_for(command, screen)
    type, arg = command.split(':')

    case type
    when "reference"
      reference = screen.references.send(arg)
      link = architects_doc_path(reference.link)
      description = reference.description
    when "data_source"
      data_source = screen.data_sources.send(arg)
      reference = screen.references.send(data_source.reference)
      link = architects_doc_path(reference.link)
      description = data_source.name
    when "screen"
      transition = screen.transitions.send(arg)
      transition_screen = Architects::Docs.find_screen(transition)
      link = architects_screen_path(transition)
      description = transition_screen.title
    end

    content_tag(:a,description,href:link,title:description).html_safe
  end

  def linkify(content, screen)
    content = content.dup
    needle = /{{([a-zA-Z:_]+)}}/

    while content.match(needle)
      content.gsub!(needle) do |m|
        match_data = m.match(needle)
        link_for(match_data[1],screen).html_safe
      end
    end

    content
  end

  def display_annotation_content annotation, screen
    output = []
    content = linkify("#{annotation.content}", screen).html_safe

    case
    when annotation.transition && content == "transition"
      link = screen.get_transition_link(annotation.transition)
      link_tag = content_tag(:a, link[:description], href: link[:link])
      output << content_tag(:p, "Transition to #{ link_tag.html_safe }".html_safe)
    when content.length > 1
      output << render(:partial=>"architects/screens/partials/condition", :locals => {condition:annotation}).html_safe
    end

    output.map(&:html_safe).join("\n").html_safe
  end
end
