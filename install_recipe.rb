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
link "/home/" + node[:current_user] do 
    to "daiki-env-setup/dotfiles/.vimrc"
end
