#!/system/bin/sh
BT_RFKILL_POINT="/sys/class/rfkill/rfkill0/"
BT_RFKILL_POINT_1="/sys/class/rfkill/rfkill1/"
SDIO_POINT="/sys/bus/sdio/devices/*/uevent"
################DEVICE_ID#################
RTL8822BS_ID="024C:B822"
MT7668BS_ID="037A:7668"
QCA6174_3_ID="0271:050A"
AP6356S_ID="02D0:4356"
##########################################
modules_dir="modules"

chipname=""
samepkg=`getprop ro.support.sampkg`
case $samepkg in
 1)
 echo "\n\nWelcome to samepkg\n\n" > /dev/kmsg
 grep "Hi3798MV320" /proc/msp/sys > /dev/null
 if [ $? -eq 0 ]; then
    chipname="Hi3798MV320"
    if [ -d /system/lib/${modules_dir}_$chipname ]; then
      modules_dir=${modules_dir}_$chipname
    fi
 else
     echo "unsupported chip!!!"
 fi
;;
 *)
  ;;
 esac
echo "\n\n chipname is $chipname\n\n" > /dev/kmsg

insmod /system/lib/$modules_dir/hi_sdio_detect.ko
echo "===>insmod sdio detect ko" > /dev/ttyAMA0

sleep 1

for sdio_retry in 1 2 3 4 5
do
 echo "===>retry $sdio_retry times" > /dev/ttyAMA0
 sdio_id=`cat $SDIO_POINT | grep SDIO_ID`
 pid_vid=${sdio_id:0-9:9}
 echo "===>get pid_vid is $pid_vid" > /dev/ttyAMA0

  if [ $pid_vid = $RTL8822BS_ID ]
     then
       echo "===>rtl8822BS" > /dev/ttyAMA0
       insmod /system/lib/$modules_dir/hi_rfkill.ko
       chmod 777 $BT_RFKILL_POINT/state
       break
     elif [ $pid_vid = $MT7668BS_ID ]
          then
            echo "===>MT7668BS" > /dev/ttyAMA0
            insmod /system/lib/$modules_dir/btmtk_sdio.ko
            break
	  elif [ $pid_vid = $QCA6174_3_ID ]
               then
                 echo "===>QCA6174-3" > /dev/ttyAMA0
                 insmod /system/lib/$modules_dir/rfkill-hi-bt.ko
                 chmod 777 $BT_RFKILL_POINT/state
                 break
            else
               echo "===>get null device id" > /dev/ttyAMA0
  fi
done
