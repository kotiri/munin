#
# Cookbook Name:: munin
# Provider:: plugin
#
# Copyright 2010-2012, OpsCode, Inc.
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
[:install, :remove].each do |action|
  action action do
    plugin = new_resource.plugin ? new_resource.plugin : new_resource.name
    config = new_resource.config ? new_resource.config : node['munin']['plugins']
    plugin_dir = new_resource.plugin_dir ? new_resource.plugin_dir : node['munin']['plugin_dir']

    cookbook_file "#{plugin_dir}/#{new_resource.name}" do
      cookbook "munin"
      source "plugins/#{new_resource.name}"
      owner "root"
      group node['munin']['root']['group']
      mode 0755
      only_if { new_resource.create_file }
    end

    link "#{config}/#{plugin}" do
      to "#{plugin_dir}/#{new_resource.name}"
      action new_resource.action == :install ? :create : :delete
      notifies :restart, resources(:service => "munin-node")
    end

    new_resource.updated_by_last_action(true)
  end
end
