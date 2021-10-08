# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:courses).with_foreign_key("owner_id") }
    it { should have_many(:enrollments) }
    it {
      should have_many(:joined_courses)
               .through(:enrollments).source(:course)
    }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it {
      should validate_length_of(:first_name)
               .is_at_least(2).is_at_most(20)
    }
    it {
      should validate_length_of(:last_name)
               .is_at_least(2).is_at_most(20)
    }
  end

  describe "#full_name" do
    it "should return first name and last name" do
      user = create(:user)
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
