# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  overview   :text             not null
#  slug       :string           not null
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
  belongs_to :subject
  belongs_to :owner, class_name: "User"

  before_save do
    self.slug = title.parameterize unless slug
  end
end
