RSpec::Matchers.define :contain_only do |expected|
  match do |actual|
    actual.sort == expected.sort
  end

  failure_message_for_should do |actual|
    "expected #{actual.inspect} to contain only #{expected.inspect}"
  end

  failure_message_for_should_not do |actual|
    "expected #{actual.inspect} not to contain #{expected.inspect}"
  end

  description do
    "contain only #{expected.inspect}"
  end
end
