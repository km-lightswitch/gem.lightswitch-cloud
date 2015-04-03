require 'aws-sdk'
require_relative 'errors'

module Lightswitch
  class Awsc

    EC2_REGIONS = %w( eu-central-1 sa-east-1 ap-northeast-1 eu-west-1 us-east-1 us-west-1 us-west-2 ap-southeast-2 ap-southeast-1 )

    def initialize(credentials)
      access_key_id = credentials[:access_key_id]
      secret_access_key = credentials[:secret_access_key]
      raise Errors::AwsCredentialsNotFoundError, 'AWS credentials were not provided' unless access_key_id && secret_access_key

      Aws.config.update({access_key_id: access_key_id, secret_access_key: secret_access_key})
      validate_access
    end

    def get_instance_status(instance_id, region_name)
      begin
        client = get_client(region_name)
        response = client.describe_instance_status({instance_ids: [instance_id], include_all_instances: true})
        if response
          response.first['instance_statuses'].first.instance_state.name
        else
          'unavailable'
        end
      end
    end

    def validate_access
      client = get_client(EC2_REGIONS.first)
      begin
        client.describe_regions
      end
      true
    end

    private

    def get_client(region_name)
      @clients_by_region ||= {}
      @clients_by_region[region_name] ||= Aws::EC2::Client.new(region: region_name)
    end

  end
end
