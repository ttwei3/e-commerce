#app/controllers/static_pages_controller.rb
class StaticPagesController < ApplicationController
  def show
    @page = StaticPage.find_by(identifier: params[:identifier])
  end

  def edit
    @page = StaticPage.find_by(identifier: params[:identifier])
  end
end
