require 'sinatra'
require 'json'

get "/rabbit_config" do
  send_file "/opt/pair/docker-sensu-server/files/rabbitmq.config"
end

get "/sensu_repo" do
  send_file "/opt/pair/docker-sensu-server/files/sensu.repo"
end

get "/sensu_config_json" do
  send_file "/opt/pair/docker-sensu-server/files/config.json"
end
get "/uchiwa_json" do
  send_file "/opt/pair/docker-sensu-server/files/uchiwa.json"
end
get "/supervisord_conf" do
  send_file "/opt/pair/docker-sensu-server/files/supervisord.conf"
end

get "/sensu_config/v1" do
  p dbg: params
  @account_id = params["auth_token"]
  @account_password = params["auth_password"]
  file = Tempfile.new("sensu-config")
  file.write(erb(:sensu_config))
  file.rewind
  file.close
  send_file file.path, filename: "config.json"
end

get "/config_consumer/amqp" do
  send_file "/opt/pair/docker-sensu-server/files/amqp.yml"
end

get "/config_consumer" do
  @account_uuid = params["account_uuid"]
  file = Tempfile.new("account")
  file.write(erb(:account))
  file.rewind
  file.close
  send_file file.path, filename: "account.yml"
end
