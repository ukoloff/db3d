class ToolsController < ApplicationController
  def index
    if params.key? 'js'
      render json: Tool.all.as_json(only: %w(id name note), methods: %w(date2str))
    end
  end

  def show
    item
    send_foto if params.key? 'img'
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
    tool_update
  end

  def new
    @tool ||= Tool.new
  end

  def create
    @tool = Tool.new
    tool_update
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

  def tool_update
    new = @tool.new_record?
    if @tool.update tool_params
      attach_foto
      redirect_to @tool
    else
      render new ? 'new' : 'edit'
    end
  end

  def attach_foto
    img = params[:tool][:img] or return
    foto = @tool.foto || @tool.build_foto
    foto.name = img.original_filename
    foto.mime = img.content_type
    foto.blob = img.read
    foto.save
  end

  def send_foto
    return redirect_to @tool unless foto = @tool.foto
    send_data foto.blob, filename: foto.name, type: foto.mime
  end
end
