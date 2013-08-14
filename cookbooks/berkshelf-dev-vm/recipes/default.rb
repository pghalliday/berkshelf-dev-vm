include_recipe "apt"
include_recipe "xml"

package "libarchive12"
package "libarchive-dev"
package "mercurial"

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby "2.0.0-p247"

rbenv_gem "bundler" do
  ruby_version "2.0.0-p247"
end

if node[:berkshelf_dev_vm][:override_git_urls]
  # git config for the vagrant user to avoid git urls (which are often blocked by corporate firewalls)
  bash "override git urls with https" do
    code <<-EOH
      su -l vagrant -c "git config --global url.\"https://\".insteadOf git://"
    EOH
  end
end

# Install gems using bundler
bash "bundle install" do
  code <<-EOH
    su -l vagrant -c "cd /berkshelf && bundle install"
  EOH
end

