class StaticController < ApplicationController
  def index
  end

  def home
    if admin_types.include?(current_user.type)
      @pending_approavls = Post.where(status: 'submitted')
      @recent_audit_items = AuditLog.last(10)
    else
      @pending_audit_confirmations = current_user.audit_logs.pending.by_start_date
    end
  end
end