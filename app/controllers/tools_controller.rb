class ToolsController < ApplicationController
  def index
    if params.key? 'js'
      render json: Tool.all
    end
  end

  def show
    item
  end

  def edit
    item
  end

  def destroy
    item or return
    @tool.destroy
    redirect_to tools_url
  end

  private

  def item
    tool = Tool.find_by_id params[:id]
    if tool
      @tool = tool
    else
      redirect_to tools_url
      nil
    end
  end
end
