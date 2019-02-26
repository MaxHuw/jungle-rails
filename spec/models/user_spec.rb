require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
 
    before(:each) do
      @user = User.new
    end

    it 'saves with all fields filled in' do
      full_user = User.new(first_name: 'a', last_name: 'b', email: 'email@email.com', password: 'apples')
      full_user.save
      expect(full_user).to be_valid
    end

    it 'is invalid without a first_name' do
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:first_name]).to include('can\'t be blank')
    end
    
    it 'is invalid without a last_name' do
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:last_name]).to include('can\'t be blank')
    end

    it 'is invalid without password' do
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password]).to include('can\'t be blank')
    end

    it 'is invalid without an email' do
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:email]).to include('can\'t be blank')
    end

    it 'requires a unique email' do
      first_user = User.new(first_name: 'Max', last_name: 'Graham', email: 'test3@test.com', password: 'test3')
      second_user = User.new(first_name: 'Max', last_name: 'hughes', email: 'test3@test.com', password: 'TEST4')
      first_user.save
      second_user.save
      expect(first_user).to be_valid
      expect(second_user).to_not be_valid
      expect(second_user.errors.messages[:email]).to include('has already been taken')
    end

  end

  describe '.authenticate_with_credentials' do
    
    it 'will authenticate if password and email are valid' do
      user = User.new(first_name: 'Max', last_name: 'Graham', email: 'max2@test.com', password: 'test1')
      user.save
      valid_user = User.authenticate_with_credentials('max2@test.com', 'test1')
      expect(valid_user).to eq(user)
    end
  
    it 'will not authenticate if password and email are valid' do
      user = User.new(first_name: 'Max', last_name: 'Graham', email: 'max3@test.com', password: 'test2')
      user.save
      invalid_user = User.authenticate_with_credentials('max3@test.com', 'test3')
      expect(invalid_user).to_not eq(user)
    end

    it 'will still authenticate if user uses uppercase letters to their email' do
      user = User.new(first_name: 'Max', last_name: 'Graham', email: 'max4@test.com', password: 'test4')
      user.save
      valid_user = User.authenticate_with_credentials('MAX4@tesT.com', 'test4')
      expect(valid_user).to eq(user)
    end

    it 'will still authenticate if user uses spaces at beginning or end of email' do
      user = User.new(first_name: 'Max', last_name: 'Graham', email: 'max5@test.com', password: 'test5')
      user.save
      valid_user = User.authenticate_with_credentials(' max5@test.com ', 'test5')
      expect(valid_user).to eq(user)
    end
  end

end
