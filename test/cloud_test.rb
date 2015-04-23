require_relative 'test_helper'

context "Lightswitch::Cloud" do

  context "raises error when constructed without AWS credentials" do
    asserts.raises(Errors::AwsCredentialsNotFoundError) { Lightswitch::Cloud.new({}) }
  end

end