class ToolsController < ApplicationController
  def index
    if params.key? 'js'
      render json: {
        tools: Tool.order(:id).as_json(
          only: %w(id name author note),
          methods: %w(date2str),
        ),
        tags: Tag.includes(:t2ts).order(:name).as_json(
          only: %w(name),
          methods: %w(_),
        )
      }
    end
    Tag.expire!
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
    @tool ||= Tool.new author: current_user.name
  end

  def create
    @tool = Tool.new creator: current_user
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
    params.require(:tool)
    .permit(%i(name date author note))
    .tap do |x|
      next if x[:date].blank?
      x[:date] = Date.new *x[:date]
        .to_s.split(/\D+/).reject(&:blank?).reverse.take(3).map(&:to_i)
    end
  end

  def tool_tags
    return unless tags = params[:tool][:tags]
    @tool.current_user = current_user
    @tool.tagnames = tags
  end

  def tool_update
    new = @tool.new_record?
    if @tool.update tool_params
      tool_tags
      attach_foto
      redirect_to @tool
    else
      render new ? 'new' : 'edit'
    end
  end

  def attach_foto
    img = params[:tool][:img] or return
    foto = @tool.foto || @tool.build_foto(creator: current_user)
    foto.name = img.original_filename
    foto.mime = img.content_type
    foto.blob = img.read
    foto.size = img.size
    foto.save
  end

  def send_foto
    return redirect_to @tool unless foto = @tool.foto
    send_data foto.blob, filename: foto.name, type: foto.mime
  end
end
