#
# Cookbook Name:: munin
# Resource:: plugin
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
actions :install, :remove

attribute :name, :kind_of => String, :name_attribute => true
attribute :plugin, :kind_of => String, :default => nil
attribute :config, :kind_of => String, :default => nil
attribute :plugin_dir, :kind_of => String, :default => nil
attribute :create_file, :kind_of => [TrueClass, FalseClass], :default => false

def initialize(*args)
  super
  @action = :install
end
