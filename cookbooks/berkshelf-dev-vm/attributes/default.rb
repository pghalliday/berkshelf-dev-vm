# This setting allows you to override the git urls with https urls in
# case your firewall blocks the git protocol
default[:berkshelf_dev_vm][:override_git_urls] = false

# Install rbenv under the vagrant user so that bundle install does not fail
# trying to install i18n due to not being able to write to:
#
# /opt/rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0/build_info/i18n-0.6.5.info
#
default[:rbenv][:user] = "vagrant"
default[:rbenv][:group_users] = ["vagrant"]
