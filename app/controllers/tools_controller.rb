class ToolsController < ApplicationController
  def index
    if params.key? 'js'
      render json: Tool.all
    end
  end
end
