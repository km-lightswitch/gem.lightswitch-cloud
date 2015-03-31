require_relative 'test_helper'

context "Lightswitch::Aws::Client" do

  context "reports AWS EC2 instance status" do
    setup { Lightswitch::Aws::Client.new({}) }
    asserts("as unavailable when there is no such instance id") { topic.get_instance_status('nonexistent_instance_id') == "unavailable" }
  end

end