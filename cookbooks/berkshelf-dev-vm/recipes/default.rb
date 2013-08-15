include_recipe "apt"
include_recipe "xml"

node[:berkshelf_dev_vm][:libarchive][:packages].each do |pkg|
  package pkg do
    action :install
  end
end

package "mercurial" do
  action :install
end

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby node[:berkshelf_dev_vm][:ruby_version]

rbenv_gem "bundler" do
  ruby_version node[:berkshelf_dev_vm][:ruby_version]
end

if node[:berkshelf_dev_vm][:override_git_urls]
  # git config for the vagrant user to avoid git urls (which are often blocked by corporate firewalls)
  bash "override git urls with https" do
    code <<-EOH
      su -l #{node[:berkshelf_dev_vm][:user]} -c "git config --global url.\"https://\".insteadOf git://"
    EOH
  end
end

# Clone the berkshelf repository
git node[:berkshelf_dev_vm][:target_directory] do
  repository node[:berkshelf_dev_vm][:git_repository]
  action :checkout
  user node[:berkshelf_dev_vm][:user]
  group node[:berkshelf_dev_vm][:group]
end

# Install gems using bundler
bash "bundle install" do
  code <<-EOH
    su -l #{node[:berkshelf_dev_vm][:user]} -c "cd #{node[:berkshelf_dev_vm][:target_directory]} && bundle install"
  EOH
end

