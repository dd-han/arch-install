#!/bin/bash

echo 'export QT_QPA_PLATFORMTHEME=qt5ct' >> /etc/xprofile
echo 'export XMODIFIERS=@im=gcin"' >> /etc/xprofile
echo 'export GTK_IM_MODULE="gcin"' >> /etc/xprofile
echo 'export QT_IM_MODULE="gcin"' >> /etc/xprofile
echo 'gcin &' >> /etc/xprofile
