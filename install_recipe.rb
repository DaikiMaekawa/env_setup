HOME_DIR = Dir.home
CURRENT_SOURCE_DIR = File.expand_path(File.dirname(__FILE__))

case node[:platform]
when "debian", "ubuntu"
    package "lldb-3.6" do
        options "-y"
    end

    package "git" do
        options "-y"
    end

    package "screen" do
        options "-y"
    end

    package "python-pip" do
        options "-y"
    end

when "redhat", "fedora"
    # redhat is including CentOS
    # something

else
    # something
end

# link to dotfiles
link HOME_DIR do 
    to CURRENT_SOURCE_DIR + "/dotfiles/.vimrc"
    not_if 'test -e %s' % HOME_DIR + "/.vimrc"
end

link HOME_DIR do
    to CURRENT_SOURCE_DIR + "/dotfiles/.screenrc"
    not_if 'test -e %s' % HOME_DIR + "/.screenrc"
end

link HOME_DIR do
    to CURRENT_SOURCE_DIR + "/dotfiles/.ycm_extra_conf_ros.py"
    not_if 'test -e %s' % HOME_DIR + "/.ycm_extra_conf_ros.py"
end
