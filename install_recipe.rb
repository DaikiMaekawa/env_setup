home_dir = "/home/" + node[:current_user]

case node[:platform]
when "debian", "ubuntu"
    package "lldb-3.6" do
        options "-y"
    end

when "redhat", "fedora"
    # redhat is including CentOS
    # something

else
    # something
end

# link to dotfiles
link home_dir do 
    to "daiki-env-setup/dotfiles/.vimrc"
    not_if 'test -e %s' % home_dir + "/.vimrc"
end

link home_dir do
    to "daiki-env-setup/dotfiles/.screenrc"
    not_if 'test -e %s' % home_dir + "/.screenrc"
end
