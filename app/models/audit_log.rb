class AuditLog < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :status, :start_date
  after_initialize :set_default

  private
    def set_default
      self.start_date ||= Date.today - 6.days
    end
end
