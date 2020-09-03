class Api::V1::ViewsController < ApplicationController
  def update
    view = View.find(params[:id])
    view.update_attributes(view_params)
    render json: view.render
  end

  private

  def view_params
    params.permit(:locked)
  end
  
end
