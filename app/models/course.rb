# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  overview   :text             not null
#  price      :decimal(8, 2)    default(0.0)
#  slug       :string           not null
#  status     :integer          default("Draft"), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#  subject_id :bigint           not null
#
# Indexes
#
#  index_courses_on_slug        (slug) UNIQUE
#  index_courses_on_subject_id  (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#  fk_rails_...  (subject_id => subjects.id)
#
class Course < ApplicationRecord
  self.per_page = 8
  belongs_to :subject
  belongs_to :owner, class_name: "User"

  validates :title, :overview, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  enum status: {
         "Draft" => 0,
         "Published" => 1,
       }

  scope :published, -> { where(status: "Published") }
  scope :by_status, ->(status = nil) { where(status: status&.capitalize) if statuses.keys.include?(status&.capitalize) }

  def is_draft?
    status == "Draft"
  end

  before_save do
    self.slug = title.parameterize unless slug
  end
end
