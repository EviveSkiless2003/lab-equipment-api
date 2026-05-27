class Equipment < ApplicationRecord
  belongs_to :category
  has_many :maintenance_records, dependent: :destroy [cite: 162]

  validates :name, presence: true, length: { minimum: 3 } [cite: 15, 17]
  validate :name_must_contain_at_least_one_letter

  validates :serial_number, presence: true, uniqueness: true, format: { with: /\A[A-Z]{3}-\d{3}\z/, message: "must be format XXX-NNN" } [cite: 18, 117]
  validates :status, presence: true, inclusion: { in: %w[available in_use maintenance] } [cite: 18]

  private

  def name_must_contain_at_least_one_letter
    if name.present? && !name.match?(/[a-zA-Z]/)
      errors.add(:name, "must contain at least one letter") [cite: 161]
    end
  end
end
