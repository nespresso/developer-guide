# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  email                  :string(255)
#  encrypted_password     :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  guest                  :boolean          default(FALSE)
#

require 'spec_helper'

describe User do
  it { should validate_presence_of(:username).with_message "can't be blank" }
  it { create(:user); should validate_uniqueness_of(:username).case_insensitive }

  it 'has a valid factory' do
    expect(create(:user)).to be_valid
  end

  describe 'creating a guest' do
    before do
      @guest = build :guest
      @guest.valid?
    end

    it 'validates presence of username' do
      @guest.username = nil
      expect(@guest).to have(1).error_on(:username)
    end

    it 'does not validate uniqueness of username' do
      create :guest, username: 'guest'
      @guest.username = 'guest'

      expect(@guest).to have(0).error_on(:username)
    end

    it 'does not validate presence of email' do
      @guest.email = nil
      expect(@guest).to have(0).errors_on(:email)
    end

    it 'does not validate presence of password' do
      @guest.password = nil
      expect(@guest).to have(0).errors_on(:password)
    end
  end

  describe 'creating a user' do
    before do
      @guest = build :user
      @guest.valid?
    end

    it 'validates presence of username' do
      @guest.username = nil
      expect(@guest).to have(1).error_on(:username)
    end

    it 'validates uniqueness of username' do
      create :user, username: 'josh'
      @guest.username = 'josh'

      expect(@guest).to have(1).error_on(:username)
    end

    it 'validates presence of email' do
      @guest.email = nil
      expect(@guest).to have(1).error_on(:email)
    end

    it 'validates presence of password' do
      @guest.password = nil
      expect(@guest).to have(1).error_on(:password)
    end
  end

  describe '.create_guest!' do
    it 'creates a guest' do
      expect {
        User.create_guest!
      }.to change { User.unscoped.count }.by 1

      expect(User.unscoped.last.guest?).to be_true
    end
  end

  describe 'scopes' do
    describe '.default' do
      it 'excludes guests' do
        user = create :user
        guest = create :guest

        expect(User.all).to eq [user]
      end
    end

    describe '.guests' do
      it 'excludes guests' do
        user = create :user
        guest = create :guest

        expect(User.guests).to eq [guest]
      end
    end
  end

  describe 'abilities' do
    context 'when is a guest' do
      before  { @guest = create(:guest) }
      subject { Ability.new(@guest) }

      it { should_not be_able_to(:manage,  User.new) }
      it { should     be_able_to(:read,    User.new) }
    end

    context 'when is a normal user' do
      before  { @user = create(:user) }
      subject { Ability.new(@user) }

      it { should_not be_able_to(:manage,  User.new) }
      it { should     be_able_to(:read,    User.new) }
      it { should     be_able_to(:update,  @user) }
      it { should_not be_able_to(:destroy, @user) }
    end

    context 'when is an admin' do
      before  { @admin = create(:admin) }
      subject { Ability.new(@admin) }

      it { should     be_able_to(:manage,  User.new) }
      it { should_not be_able_to(:destroy, @user) }
    end
  end
end
