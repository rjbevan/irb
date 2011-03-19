require './test_helper'

class CountryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "should not save country without name" do
    country = Country.new
    assert !country.save, "Saved the country without a name"
  end

  test "should report error" do
    # some_undefined_variable is not defined elsewhere in the test case
    some_undefined_variable
    assert true
  end
end
