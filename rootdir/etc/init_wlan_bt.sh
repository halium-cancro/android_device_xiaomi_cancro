#!/system/bin/sh
## The Ubports project
## Wait for WCNSS service to setup WLAN device over QMI
# Workaround for conn_init not copying the updated firmware

#rm /data/misc/wifi/WCNSS_qcom_cfg.ini
#rm /data/misc/wifi/WCNSS_qcom_wlan_nv.bin

#logwrapper /system/bin/conn_init

echo 1 > /dev/wcnss_wlan
echo sta > /sys/module/wlan/parameters/fwpath

enable_bt () {
       if [[ `getprop ro.qualcomm.bt.hci_transport` != "smd" ]]; then
           setprop ro.qualcomm.bt.hci_transport smd
       fi
       #initialize bt device
       /system/bin/hci_qcomm_init -e
       sleep 1 
       echo 1 > /sys/module/hci_smd/parameters/hcismd_set
}
#while true; do
#   sleep 2
#   if [ ! -f /sys/devices/fb000000.qcom,wcnss-wlan/net/wlP1p1s0/address ]; then
#       echo sta > /sys/module/wlan/parameters/fwpath
#   #else
#       # enable bluetooth here since we have to wait for wlan to be #initialized
#       #enable_bt
#       #break
#   fi
#done
