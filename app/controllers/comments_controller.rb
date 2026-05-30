# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: 'コメントを投稿しました。'
    else
      redirect_to @commentable, alert: 'コメントの投稿に失敗しました。'
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy!
    redirect_to @commentable, status: :see_other, notice: 'コメントを削除しました。'
  end

  private

  def set_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    elsif params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def comment_params
    params.expect(comment: [:body])
  end
end
