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
end
