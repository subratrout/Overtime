class StaticController < ApplicationController
  def index
  end

  def home
    @pending_approavls = Post.where(status: 'submitted')
  end
end