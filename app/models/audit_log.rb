class AuditLog < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :status, :start_date
  after_initialize :set_default
  enum status: { pending: 0, confirmed: 1}
  before_update :set_end_date, if: :confirmed?

  private
    def set_default
      self.start_date ||= Date.today - 6.days
    end

    def set_end_date
      self.end_date = Date.today
    end
end
