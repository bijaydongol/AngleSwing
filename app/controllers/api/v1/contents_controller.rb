class Api::V1::ContentsController < ApplicationController
  respond_to :json
  before_action :set_content, only: %i[show update destroy authorized_user?]
  before_action :authorized_user?, only: %i[update destroy]

  # GET /api/v1/contents
  def index
    @contents = Content.page(params[:page]).per(params[:batch])
    render json: ContentSerializer.new(@contents), status: :ok
  end

  # POST /api/v1/contents
  def create
    @content = Content.new(content_params.merge(user: current_user))
    if @content.save
      render json: ContentSerializer.new(@content), status: :created
    else
      render json: @content.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/contents/:id
  def show
    render json: ContentSerializer.new(@content), status: :ok
  end

  # PUT /api/v1/contents/:id
  def update
    if @content.update(content_params)
      render json: ContentSerializer.new(@content), status: :ok
    else
      render json: @content.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/contents/:id
  def destroy
    @content.destroy
    render json: { message: "Content deleted successfully." }, status: :ok
  end

  private

  def authorized_user?
    unless @content.user == current_user
      render json: {error: "You are not authorized to perform this action."}, status: :forbidden
    end
  end

  def set_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:title, :body)
  end
end
