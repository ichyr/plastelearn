class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    authorize @comment

    if current_user
      @comment.user_id = current_user.id
      @comment.save
    else
      flash[:notice] = 'You need to be logged in to create a comment.'
    end

    # respond_with(@comment)
    redirect_to controller: :homeworks, action: :show, id: comment_params[:homework_id]
  end

  def update
    authorize @comment

    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    authorize @comment
    
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text, :homework_id)
    end
end
