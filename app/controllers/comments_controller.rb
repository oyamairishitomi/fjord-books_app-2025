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

    if @comment.user == current_user
      @comment.destroy!
      redirect_to @commentable, status: :see_other, notice: 'コメントを削除しました。'
    else
      redirect_to @commentable, status: :see_other, alert: '自分のコメントのみ削除できます。'
    end
  end

  private

  def set_commentable
    key = params.keys.find { |k| k.end_with?('_id') }
    model_name = key.delete_suffix('_id')
    model_class = model_name.classify.constantize
    @commentable = model_class.find(params[key])
  end

  def comment_params
    params.expect(comment: [:body])
  end
end
