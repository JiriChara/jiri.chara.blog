class AboutSideCell < Cell::Rails
  include CanCan::ControllerAdditions

  helper MarkdownHelper

  attr_reader :current_user

  def show(args)
    append_view_path("app/views")

    @current_user = args[:current_user]
    @about_side = AboutSide.actual
    render
  end
end
