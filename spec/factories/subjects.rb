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
FactoryBot.define do
  factory :subject do
    title { "MyString" }
    slug { "MyString" }
  end
end
