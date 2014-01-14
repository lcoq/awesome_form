require 'awesome_form/methods/attributes'
require 'awesome_form/methods/inputs'
require 'awesome_form/methods/actions'

module AwesomeForm
  class FormBuilder < ActionView::Helpers::FormBuilder
    include AwesomeForm::Methods::Attributes
    include AwesomeForm::Methods::Inputs
    include AwesomeForm::Methods::Actions

    def initialize(*)
      super
    end

    def render(render_options)
      @template.render(render_options)
    end

    def view_exists?(view)
      path_elements = view.split('/')
      view = "_#{path_elements.pop}"
      prefix = path_elements.join('/')

      @template.lookup_context.exists? view, [prefix]
    end

    def input_name(attribute_name)
      "#{object_name}[#{attribute_name}]"
    end

    def collection_name(attribute_name, index=nil)
      "#{object_name}[#{attribute_name}][#{index}]"
    end

  protected

    def model_name
      object.class.name.underscore.pluralize
    end

    def filter_arguments(*args)
      options = {}

      symbols = args.select {|a| a.is_a? Symbol }
      options_args = args.select {|a| a.is_a? Hash }
      options_args.each {|h| options.merge! h }

      [symbols, options]
    end

  end
end