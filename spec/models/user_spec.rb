require 'rails_helper'


RSpec.describe User, type: :model do
  describe User do
    before do
      @user = FactoryBot.build(:user)
    end
    

    describe 'Register new user' do
      context 'Unsuccesful registration' do
        it 'Throws an error when email is empty' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it 'Throws an error when password is too short' do
          @user.password = "qwert"
          @user.password_confirmation = "quert"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        end
        it 'Throws an error when password is empty' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'Throws an error when passwords dont match' do
          @user.password = "qwert"
          @user.password_confirmation = "quer"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'Registration fails if duplicate emails' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        
      end

      context 'Successful registration' do 
        it "Registers password if correct" do
          @user.password = "qwerty"
          @user.password_confirmation = "qwerty"
          expect(@user).to be_valid
        end
        it "Registers email if correct" do
          @user.email = "userName@gmail.com"
          expect(@user).to be_valid
        end
      end

    end

    
  end
end

