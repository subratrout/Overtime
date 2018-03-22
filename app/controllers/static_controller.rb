class StaticController < ApplicationController
  def index
  end

  def home
    @pending_approavls = Post.where(status: 'submitted')
    @recent_audit_items = AuditLog.last(10)
  end
end