class UserTest < ActiveSupport::TestCase

  def test_valid
    user = build(:user)
    assert user.valid?, "Can't create with valid params: #{user.errors.messages}"
  end

  def test_invalid_without_email
    params = attributes_for(:user)
    params.delete :email
    user = User.new params

    refute user.valid?, "Can't be valid without email"
    assert user.errors[:email], "Missing error when without email"
  end

  def test_invalid_without_first_name
    params = attributes_for(:user)
    params.delete :first_name
    user = User.new params

    refute user.valid?, "Can't be valid without first name"
    assert user.errors[:first_name], "Missing error when first name"
  end

  def test_invalid_without_last_name
    params = attributes_for(:user)
    params.delete :last_name
    user = User.new params

    refute user.valid?, "Can't be valid without last name"
    assert user.errors[:last_name], "Missing error when last name"
  end

  def test_invalid_without_phone_number
    params = attributes_for(:user)
    params.delete :phone_number
    user = User.new params

    refute user.valid?, "Can't be valid without phone number"
    assert user.errors[:phone_nuber], "Missing error when phone number"
  end

  def test_invalid_without_gender
    params = attributes_for(:user)
    params.delete :gender
    user = User.new params

    refute user.valid?, "Can't be valid without gender"
    assert user.errors[:gender], "Missing error when without gender"
  end

end
