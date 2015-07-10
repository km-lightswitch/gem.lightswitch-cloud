require 'aws-sdk'
require_relative 'errors'

module Lightswitch
  class Cloud

    EC2_REGIONS = %w( eu-central-1 sa-east-1 ap-northeast-1 eu-west-1 us-east-1 us-west-1 us-west-2 ap-southeast-2 ap-southeast-1 )

    def initialize(credentials)
      access_key_id = credentials[:access_key_id]
      secret_access_key = credentials[:secret_access_key]
      raise Errors::AwsCredentialsNotFoundError, 'AWS credentials were not provided' unless access_key_id && secret_access_key

      Aws.config.update({access_key_id: access_key_id, secret_access_key: secret_access_key})
      validate_access
    end

    def list_instances(region_name)
      instance_info = []
      begin
        client = get_client(region_name)
        response = client.describe_instances

        if response
          instances = response['reservations'].collect do |struct|
            struct['instances']
          end
          instance_info = instances.collect do |instance_struct|
            instance = instance_struct.first
            {
                instance_id: instance.instance_id,
                name_tag: (instance['tags'].last.value || ''),
                state: instance.state['name'],
                public_dns_name: instance.public_dns_name,
            }
          end
        end
      end
      instance_info
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
