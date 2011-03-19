require 'test_helper'

class CountriesControllerTest < ActionController::TestCase
  setup do
    @country = countries(:one)
    @update = {
      :mane => 'Ruritania',
      :rating_current => 80.000,
      :date_current => "2100-01-01"
    }
  end
end
