require "test_helper"

describe Place do
  let(:place) { Place.new }

  it "must be valid" do
    place.must_be :valid?
  end
end
