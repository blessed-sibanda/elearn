# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subjects_on_slug  (slug) UNIQUE
#
class Subject < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :slug, uniqueness: true
  has_many :courses

  before_save do
    self.slug = title.parameterize unless slug
  end

  scope :with_courses, -> {
          joins(:courses).group(:id).where("courses.status = ?", 1)
        }
end
