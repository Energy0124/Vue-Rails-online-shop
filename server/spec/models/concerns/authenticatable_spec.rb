require 'spec_helper'

describe Concerns::Authenticatable do
  let(:user) { create :user }

  describe 'responds to attrs' do
    it { expect(user).to respond_to(:email) }
    it { expect(user).to respond_to(:password) }
    it { expect(user).to respond_to(:password_confirmation) }
    it { expect(user).to respond_to(:auth_token) }
  end

  describe 'validates' do
    it 'presence of basic attrs' do
      new_user = User.new
      expect(new_user.valid?).to be false
      expect(new_user.errors.keys).to include(:email)
      expect(new_user.errors.keys).to include(:password)
    end

    it 'auth_token is unique' do
      another_user = create(:user)
      another_user.auth_token = user.auth_token
      expect do
        another_user.save!
      end.to raise_error(ActiveRecord::RecordNotUnique)
      another_user.auth_token = 'different_token'
      another_user.save
      expect(another_user).to be_valid
    end

    it 'email is unique' do
      expect do
        create(:user, email: user.email)
      end.to raise_error(ActiveRecord::RecordInvalid)

      expect(create(:user, email: 'different@mail.com')).to be_valid
    end

    it 'email format' do
      %w(test_mail mail.test).each do |email|
        expect do
          create(:user, email: email)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      %w(a.b.c@example.com test_mail@gmail.com any@any.net
         email@test.br 123@mail.test 1☃3@mail.test).each do |email|
        expect(create(:user, email: email)).to be_valid
      end
    end

    it 'password length' do
      expect do
        create(:user,
               password: '1234',
               password_confirmation: '1234')
      end.to raise_error(ActiveRecord::RecordInvalid)

      expect do
        create(:user,
               password: 'x' * 80,
               password_confirmation: 'x' * 80)
      end.to raise_error(ActiveRecord::RecordInvalid)

      expect(create(:user,
                    password: '12345678',
                    password_confirmation: '12345678')).to be_valid
    end

    it 'password confirmation' do
      expect do
        create(:user,
               password: 'one_password',
               password_confirmation: 'another_password')
      end.to raise_error(ActiveRecord::RecordInvalid)

      expect(create(:user, password: 'same_password',
                           password_confirmation: 'same_password')).to be_valid
    end
  end
end
