#!/usr/bin/env bash

########################################################################
#created by br0k3ngl255
#license: GPLv3
#
########################################################################

###Variables
HOME=$(pwd)
INST_DIR="/opt"
TMP="/tmp"
LINK="http://eclipse.bluemix.net/packages/neon.3/data/eclipse-jee-neon-3-linux-gtk-x86_64.tar.gz"
FILE="eclipse.tar.gz"
NAME="eclipse"
###Functions
net_check(){
cmd=$(ping -c 1 vk.com &> /dev/null; echo $?)
	if  (($cmd == 0 ));then
		echo "Network Up"
	else
		echo "Network Down, exiting...";exit
	fi
}

get_eclipse(){

wget  $LINK -P $TMP -O $FILE &> /dev/null
tar xvzf $TMP/$FILE -C $INST_DIR

}

eclipse_setup(){

cat <<EOF >> /usr/share/applications/$NAME.desktop
[Desktop Entry]
Type=Application
Version=
Name=Eclipse
Exec=eclipse %F
Icon=eclipse
Terminal=false
Categories=GTK;Development;IDE;
StartupNotify=true

EOF

cat << EOF >> /usr/bin/$NAME
#!/usr/bin/env bash

BIN="/opt/eclipse"

	$BIN/eclipse $*

EOF

chmod +x /usr/bin/$NAME

	}

permission_setup(){
	cmd=$(cat /etc/passwd|awk -F : {'print $3'})
	for i in $cmd ; do 
		if (($i>=1000))&&(($i<=2000));then
			chown $i:$i $INST_DIR/$NAME -R
			break
		fi 
	 done
	}

####
#Main - _ -- _ -- _ -- _ -- _ -- _ -- _ -- _ -- _ -- _ -- _ -- _ -- _ -
####

if (($EUID == 0));then
	net_check;
		
	if [ -e $INST_DIR/$NAME ];then
		true
	elif [ ! -e $INST_DIR/$NAME ];then
		get_eclipse
	fi
	eclipse_setup;permission_setup
fi 
