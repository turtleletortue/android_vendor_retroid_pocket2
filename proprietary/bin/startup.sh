#!/system/bin/sh

setenforce 0

# sdcard mount to data
part_exfat=/dev/block/mmcblk1p2
part_ext4=/dev/block/mmcblk1p1
flag_file=/nvdata/VIRTUAL_INTERNAL_STORAGE.FLG

if [ -f $flag_file ];then
	if [ -b $part_ext4 ];then
		umount /data
		mount -o rw -t ext4 $part_ext4 /data
		if [ $? -ne 0 ];then
			rm $flag_file
			mount -o rw,noatime,nosuid,nodev -t ext4 $data_dev /data
			if [ $? -ne 0 ];then
				reboot
			fi
		fi
	fi
fi

# fonts
if [ ! -f /data/system/fonts/warning ]; then
	tar xf /system/fonts.tar -C /data
	echo "don't remove this dir files" > /data/system/fonts/warning
fi

# user boot script
user_boot_script_deamon=/system/bin/boot.sh
user_boot_script_old=/nvdata/boot.sh	
user_boot_script=/nvdata/boot/boot.sh

if [ -f $user_boot_script_old ];then
	rm $user_boot_script_old -rf
fi

if [ -f $user_boot_script_deamon ]; then
	if [ ! -f $user_boot_script ]; then
		mkdir -p $(dirname $user_boot_script)
		cp $user_boot_script_deamon $user_boot_script
	fi
	/system/bin/sh $user_boot_script
fi
