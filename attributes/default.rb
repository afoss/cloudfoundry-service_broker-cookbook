# The host portion of the externally-visible URL (e.g. service-broker.vcap.me).
default['cloudfoundry_service_broker']['host'] = "service-broker"

# Unique instance index.
default['cloudfoundry_service_broker']['index'] = 0

# Log level for the service_broker service.
default['cloudfoundry_service_broker']['log_level'] = "info"

# Where to write the service_broker service's logs.
default['cloudfoundry_service_broker']['log_file'] = File.join(node['cloudfoundry_common']['log_dir'], "service_broker.log")

# Base directory for instance-specific data
default['cloudfoundry_service_broker']['base_dir'] = File.join(node['cloudfoundry_common']['services_dir'], "service_broker")

# Where to write the mongodb service node's pid.
default['cloudfoundry_service_broker']['pid_file'] = File.join(node['cloudfoundry_common']['pid_dir'], "service_broker.pid")
