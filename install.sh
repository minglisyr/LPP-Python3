#!/bin/bash

PREFIX=$HOME/bin

USAGE="usage\n\t./install.sh [-p path] [-h]\n\
\t-p\tset install directory\n\
\t-h\thelp"

# get prefix if passed
while getopts "p:h" OPTION; do
	case $OPTION in
		p )
			PREFIX=$OPTARG
			;;
		h )
			echo -e $USAGE
			exit 4
			;;
		? )
			echo -e $USAGE
			exit 4
			;;
	esac
done


# check prefix
if [[ ! -d $PREFIX ]]; then
	echo "directory '$PREFIX' not found"
	echo "create directory or choose different install directory using the -p flag"
	exit 1
fi


# check old installations
echo "checking for old installations..."
if hash lpp 2>/dev/null ; then
	echo "WARNING: lpp is already installed on your system."
	echo "         please remove $(which lpp) before reinstalling."
fi
if hash pizza 2>/dev/null ; then
	echo "WARNING: pizza is already installed on your system."
	echo "         please remove $(which pizza) before reinstalling."
fi
if hash lpp 2>/dev/null ; then
	exit 2;
fi
if hash pizza 2>/dev/null ; then
	exit 2;
fi


# create symlinks
echo "creating symlinks..."
ln -s $(pwd)/src/lpp.py $PREFIX/lpp
if [ $? -ne 0 ]; then
	echo "cannot create symbolic link for lpp"
	echo "use a different install directory or try calling this script as root"
	exit 3
fi

ln -s $(pwd)/src/pizza.py $PREFIX/pizza
if [ $? -ne 0 ]; then
	echo "cannot create symbolic link for pizza"
	echo "use a different install directory or try calling this script as root"
	exit 3
fi


# update path if lpp cannot be found
if ! hash lpp 2>/dev/null; then
	echo "updating path..."
	echo -e "\n" >> $HOME/.bashrc
	echo 'export PATH='$PREFIX':$PATH' >> $HOME/.bashrc
	echo -e "\n" >> $HOME/.bashrc
	export PATH=$PREFIX:$PATH
	echo "please execute the command 'bash' to finalize the installation"
fi
