#!/bin/bash

echo "1-Configuration du mot de passe root"
#password=toor
#yes "$password" | passwd # Doesn't work
sed -Ei- 's|^root:.*|root:$6$OOMOk/dXZXN1Anfr$fJuuwSgaVaX8ip8rBHykdIdg1YIuQ8YBkHfsXUWCvp/3h2CGI12KA/eN4HcFkRsDHKKd6opKlHWZuDxtw.jAN/:19790:0:99999:7:::|' /etc/shadow
echo "root password has been set to toor"

echo "2-Configuration du nom de la machine"
p3_uuid=$(blkid /dev/mmcblk*p3 | sed 's/.* UUID="//; s/".*//')
[ "$p3_uuid" = 56752e43-b0fe-4505-b6b1-8a6369d82fdd ] && hostname=as-a || hostname=as-s
echo "$hostname" > /etc/hostname

echo "3-Configuration des addresses statiques"
cat > /etc/hosts <<< \
"# Begin /etc/hosts

127.0.0.1 localhost.localdomain localhost
127.0.1.1 $hostname.upcite $hostname
::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters

# End /etc/hosts
"

echo "4-Configuration du temps"
cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
LOCAL
EOF

echo "5-Configuration de la keymap"
cat > /etc/vconsole.conf << "EOF"
KEYMAP=us
FONT=Lat2-Terminus16
EOF

echo "6-Configuration de la locale"
cat > /etc/locale.conf << "EOF"
LANG=en_US.utf8
EOF

echo "6-Configuration de inputrc"
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8-bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF

echo "6-Configuration des shells disponibles"
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF

echo "6-Identification de la distribution"
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="UPCite Linux"
DISTRIB_RELEASE="2"
DISTRIB_CODENAME="Moreno"
DISTRIB_DESCRIPTION="UPCite Linux"
EOF

echo "6bis-Identification de la distribution"
cat > /etc/os-release << "EOF"
NAME="UPCite Linux"
VERSION="2"
ID=upc
PRETTY_NAME="UPCite Linux 2"
VERSION_CODENAME="Moreno"
EOF

#echo "7-Obtention du UUID de /dev/mmcblk*p3"
#blkid /dev/mmcblk*p3

echo "Exit chroot and run /set-p3-as-boot-partition.sh"
