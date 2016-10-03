class ToolsController < ApplicationController
  def index
    if params.key? 'js'
      render json: Tool.all.as_json(only: %w(id name), methods: %w(date2str))
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

  def update
    item or return
    if @tool.update tool_params
      redirect_to @tool
    else
      render 'edit'
    end
  end

  def new
    @tool ||= Tool.new
  end

  def create
    @tool = Tool.new tool_params
    if @tool.save
      redirect_to @tool
    else
      render 'new'
    end
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

  def tool_params
    params.require(:tool).permit %i(name date note)
    # z[:date] = Date.new(*z[:date].split(/\D+/).reverse.map(&:to_i)) unless z[:date].blank?
    # z
  end
end
