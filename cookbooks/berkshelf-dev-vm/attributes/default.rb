default[:berkshelf_dev_vm][:target_directory] = "/berkshelf"
default[:berkshelf_dev_vm][:git_repository] = "https://github.com/RiotGames/berkshelf.git"
default[:berkshelf_dev_vm][:user] = "vagrant"
default[:berkshelf_dev_vm][:group] = "vagrant"
default[:berkshelf_dev_vm][:ruby_version] = "2.0.0-p247"

# libarchive packages
case node[:platform_family]
when "rhel", "fedora"
  default[:berkshelf_dev_vm][:libarchive][:packages] = %w{ libarchive libarchive-devel }
when "ubuntu","debian"
  default[:berkshelf_dev_vm][:libarchive][:packages] = %w{ libarchive12 libarchive-dev }
when "freebsd", "arch"
  # Haven't tried this one yet
  default[:berkshelf_dev_vm][:libarchive][:packages] = %w{ libarchive }
end

# This setting allows you to override the git urls with https urls in
# case your firewall blocks the git protocol
default[:berkshelf_dev_vm][:override_git_urls] = false

# Install rbenv under the vagrant user so that bundle install does not fail
# trying to install i18n due to not being able to write to:
#
# /opt/rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0/build_info/i18n-0.6.5.info
#
default[:rbenv][:user] = node[:berkshelf_dev_vm][:user]
default[:rbenv][:group_users] = [node[:berkshelf_dev_vm][:user]]
