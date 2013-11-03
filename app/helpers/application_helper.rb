module ApplicationHelper
  def flash_message(flash)
    render(partial: "partials/flash_message", locals: { flash: flash })
  end
end
