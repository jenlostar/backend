require "test_helper"

describe Schedule do
  let(:schedule) { Schedule.new }

  it "must be valid" do
    schedule.must_be :valid?
  end
end
