require 'etc'

HOME_DIR = Dir.home
CURRENT_SOURCE_DIR = File.expand_path(File.dirname(__FILE__))
CURRENT_USER_NAME = Etc.getlogin
puts "CURRENT_USER_NAME = " + CURRENT_USER_NAME

case node[:platform]
when "debian", "ubuntu"
    package "lldb-3.6" do
        options "-y"
    end

    package "gdb" do
        options "-y"
    end

    package "gdbserver" do
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

    package "trash-cli" do
        options "-y"
    end

    package "vim" do
        options "-y"
    end

    package "doxygen" do
        options "-y"
    end

    package "xmonad" do
        options "-y"
    end

    package "xmobar" do
        options "-y"
    end

    package "libclang-3.8-dev" do
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

directory HOME_DIR + "/.vim" do
    mode "775"
    owner CURRENT_USER_NAME
    group CURRENT_USER_NAME
    not_if 'test -e %s' % HOME_DIR + "/.vim"
end

directory HOME_DIR + "/.vim/colors" do
    mode "775"
    owner CURRENT_USER_NAME
    group CURRENT_USER_NAME
    not_if 'test -e %s' % HOME_DIR + "/.vim/colors"
end

link HOME_DIR + "/.vim/colors" do
    to CURRENT_SOURCE_DIR + "/schemes/molokai/molokai.vim"
    not_if 'test -e %s' % HOME_DIR + "/.vim/colors/molokai.vim"
end

directory HOME_DIR + "/.xmonad" do
    mode "775"
    owner CURRENT_USER_NAME
    group CURRENT_USER_NAME
    not_if 'test -e %s' % HOME_DIR + "/.xmonad"
end

link HOME_DIR + "/.xmonad/xmonad.hs" do
    to CURRENT_SOURCE_DIR + "/dotfiles/.xmonad/xmonad.hs"
    not_if 'test -e %s' % HOME_DIR + "/.xmonad/xmonad.hs"
end

link HOME_DIR + "/.xmobarrc" do
    to CURRENT_SOURCE_DIR + "/dotfiles/.xmobarrc"
    not_if 'test -e %s' % HOME_DIR + "/.xmobarrc"
end

