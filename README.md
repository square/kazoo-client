# Kazoo::Client

Client library gem for use with the 2600Hz Kazoo phone system

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kazoo-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kazoo-client

## Usage Examples

### Initialize
This will log in and get an auth token

    api_url = "https://api.example.com"
    version = "v2"
    session = Kazoo::Client.new(api_url, version, username, password, realm)

You can then do any of the api calls until the auth token expires

### Devices
Devices are often physical devices, but can be softphones, landlines, etc.

**Get all Devices**

    devices = session.get_devices

**Add a Device**

    device = { data: {
      name: '100',
      device_type: 'sip_device',
      enabled: true,
      mac_address: 'de:ad:be:ef:ca:fe' } }
    session.add_device(device)

**Get a Device**

    device_id = '0123456789abcdef0123456789abcdef'
    session.get_device(device_id)

**Update a Device**

    device = { data: {
      name: '101',
      device_type: 'sip_device',
      enabled: true,
      mac_address: 'de:ad:be:ef:ca:fe' } }
    session.update_device(device_id, device)

**Sync or reboot a device**

    session.sync_device(device_id)

*sync_device is an api v2 only call*

**Delete a Device**

    session.delete_device(device_id)

### Users

**Get all Users**

    users = session.get_users

**Add a User**

    user = { data: {
      first_name:"George",
      last_name:"Test",
      username:"georgetest",
      vm_to_email_enabled:true } }
    session.add_user(user_json)

**Get a User**

    user_id = '0123456789abcdef0123456789abcdef'
    session.get_user(user_id)

**Update a User**

    user = { data: {
      first_name:"George",
      last_name:"Test 2",
      username:"georgetest",
      vm_to_email_enabled:true } }
    session.update_user(user_id, user)

**Delete a User**

    session.delete_user(user_id)

**Get all hotdesk**

    session.get_all_hotdesk

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/square/kazoo-client.

## License

Copyright 2017 Square, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License. You may
obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.

