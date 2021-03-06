module DeviseHelper
  # A simple way to show error messages for the current devise resource. If you need
  # to customize this method, you can either overwrite it in your application helpers or
  # copy the views to your application.
  #
  # This method is intended to stay simple and it is unlikely that we are going to change
  # it to add more behavior or options.
  def devise_error_messages!
    resource_errors = resource.errors
    return '' if resource_errors.empty?

    messages = resource_errors.full_messages.map { |msg| content_tag(:p, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource_errors.count,
                      resource: resource.class.model_name.human.downcase)
    html = "<div id='error-explanation'>#{messages}</div>"
    html.html_safe
  end
end
