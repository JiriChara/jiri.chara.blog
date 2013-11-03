class AboutSideCell < Cell::Rails

  def show
    @about_side = AboutSide.actual
    render
  end
end
