class Api::V1::ViewsController < ApplicationController

  def update
    puts params
    view = View.find(params[:id])
    view.update_attributes(view_params)
    render json: view.render
  end

  def test 
    views = View.last(3)
    render json: views
  end

  private

  def view_params
    params.permit(:locked, :viewed)
  end
  
end
