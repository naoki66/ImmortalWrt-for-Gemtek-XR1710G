REQUIRE_IMAGE_METADATA=1
RAMFS_COPY_BIN='fitblk fit_check_sign'

platform_do_upgrade() {
	local board=$(board_name)

	case "$board" in
		gemtek,w1700k-ubi|\
		gemtek,xr1710g-ubi|\
		gemtek,xg2010g-ubi)
			fit_do_upgrade "$1"
			;;
		nokia,xg-040g-md)
			nand_do_upgrade "$1"
			;;
		*)
			nand_do_upgrade "$1"
			;;
	esac
}

platform_check_image() {
	return 0
}
