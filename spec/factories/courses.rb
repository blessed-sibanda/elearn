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
FactoryBot.define do
  factory :course do
    title { Faker::Lorem.paragraph + SecureRandom.hex(3) }
    overview { Faker::Lorem.paragraphs.join }
    association :owner, factory: :user, strategy: :build
    association :subject, strategy: :build

    trait :with_random_status do
      status { Course.statuses.keys.sample }
    end
  end
end
