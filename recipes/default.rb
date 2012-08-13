#
# Cookbook Name:: cloudfoundry_service_broker
# Recipe:: default
#
# Copyright 2012, ZephirWorks
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

install_path = File.join(node['cloudfoundry_common']['vcap_services']['install_path'], "service_broker")

cloudfoundry_common_source "service_broker" do
  path          install_path
  repository    node['cloudfoundry_common']['vcap_services']['repo']
  reference     node['cloudfoundry_common']['vcap_services']['reference']
  subdirectory  "service_broker"
end

template "#{node['cloudfoundry_common']['config_dir']}/service_broker-pre_defined_services.yml" do
  source   "pre_defined_services.yml.erb"
  owner    node['cloudfoundry_common']['user']
  mode     "0644"
end

cloudfoundry_common_component "service_broker" do
  install_path  File.join(install_path, "service_broker")
  bin_file      File.join(install_path, "service_broker", "bin", "service_broker")
  pid_file      node['cloudfoundry_service_broker']['pid_file']
  log_file      node['cloudfoundry_service_broker']['log_file']
  extra_args    "-p #{node['cloudfoundry_common']['config_dir']}/service_broker-pre_defined_services.yml"
  action        [:create, :enable]
  subscribes    :restart, resources("cloudfoundry-common_source" => "service_broker")
end
