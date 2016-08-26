#!/bin/bash

case $1 in

# docbook slots
app-text/docbook-sgml-dtd)               echo "=$1-3.0-r3"
                                         echo "=$1-3.1-r3"
                                         echo "=$1-4.0-r3"
                                         echo "=$1-4.1-r3";;
app-text/docbook-xml-dtd)                echo "=$1-4.1.2-r6"
                                         echo "=$1-4.2-r2"
                                         echo "=$1-4.3-r1"
                                         echo "=$1-4.4-r2"
                                         echo "=$1-4.5-r1";;
app-text/docbook-xml-simple-dtd)         echo "=$1-1.0-r1"
                                         echo "=$1-4.1.2.4-r2";;

# autoconf/make slots
sys-devel/autoconf)                      echo "$1";;
sys-devel/automake)                      echo "=$1-1.14.1"
                                         echo "$1";;
sys-devel/binutils-config)               echo "=$1-5-r2";;

# ncurses slots
sys-libs/ncurses)                        echo "=$1-5.9-r5"
                                         echo "$1";;

# python
dev-lang/python)                         echo "=$1-2.7.10-r1";;

# ruby
dev-lang/ruby)                           echo "=$1-2.2.5";;
app-eselect/eselect-ruby)                echo "=$1-20151229";;
dev-ruby/hashie)                         echo "=$1-3.4.4";;
dev-ruby/highline)                       echo "=$1-1.7.8";;
dev-ruby/json)                           echo "=$1-1.8.3";;
dev-ruby/net-ssh)                        echo "=$1-3.1.1";;
dev-ruby/rake)                           echo "=$1-11.1.2";;
dev-ruby/rubygems)                       echo "=$1-2.5.2";;
dev-ruby/uuidtools)                      echo "=$1-2.1.5";;
virtual/rubygems)                        echo "=$1-11";;

# kernel
sys-kernel/gentoo-sources)               echo "=$1-4.6.3";;
sys-kernel/linux-headers)                echo "=$1-4.6";;

# vim
app-editors/vim)                         echo "=$1-7.4.2102";;
app-editors/vim-core)                    echo "=$1-7.4.2102";;

# postgres
dev-db/postgresql)                       echo "=$1-9.4.9"
                                         echo "=$1-9.5.4";;

app-emulation/lxc)                       echo "=$1-1.1.5";;
dev-lang/go)                             echo "=$1-1.7";;
dev-vcs/bzr)                             echo "=$1-2.6.0";;
net-analyzer/nagios)                     echo "=$1-3.5.1";;
net-analyzer/nagios-core)                echo "=$1-3.5.1";;
virtual/jpeg)                            echo "=$1-0-r2";;

*)                                       echo $1;;
esac
