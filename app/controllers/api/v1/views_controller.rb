class Api::V1::ViewsController < ApplicationController
  def update
    view = View.find(params[:id])
    view.update_attributes(view_params)
    render json: view.render
  end

  def backload_post
    post_view = View.find(params[:view_id]).post_view_render
    render json: post_view
  end


  private

  def view_params
    params.permit(:ad_view, :viewed)
  end
  
end
