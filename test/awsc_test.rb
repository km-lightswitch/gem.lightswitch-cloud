require_relative 'test_helper'

context "Lightswitch::Awsc" do

  context "raises error when constructed without AWS credentials" do
    asserts.raises(Errors::AwsCredentialsNotFoundError) { Lightswitch::Awsc.new({}) }
  end

end