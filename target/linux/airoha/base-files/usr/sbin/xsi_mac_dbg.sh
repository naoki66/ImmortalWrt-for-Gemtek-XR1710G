reg_c1()
{
  NAME=$1
  BASE=$2
  OFF=$3

  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  printf "%-30s  = %-10s, " $NAME $RES

}

reg_c2()
{
  NAME=$1
  BASE=$2
  OFF=$3

  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  printf "%-30s    = %-10s\n" $NAME $RES 
}

seg_c1()
{
  NAME=$1
  BASE=$2
  OFF=$3
  SHIFT=$4

  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  RES_S=$(($RES >> $SHIFT))
  RES_M=$(($RES_S & 0xFFFF))

  printf "%-30s  = 0x%08X, " $NAME $RES_M
}

seg_c2()
{
  NAME=$1
  BASE=$2
  OFF=$3
  SHIFT=$4

  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  RES_S=$(($RES >> $SHIFT))
  RES_M=$(($RES_S & 0xFFFF))
  printf "%-30s    = 0x%08X\n" $NAME $RES_M
}

check_bit()
{
  NAME=$1
  BASE=$2
  OFF=$3
  BIT=$4

  MASK=$((1 << $BIT))
  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  RES_M=$(($RES & $MASK))
  if [ $RES_M -gt 0 ]; then
    printf "%-30s  Enabled\n" $NAME
  else
    printf "%-30s  Disabled\n" $NAME
  fi
}

check_bit_i()
{
  NAME=$1
  BASE=$2
  OFF=$3
  BIT=$4

  MASK=$((1 << $BIT))
  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  RES_M=$(($RES & $MASK))
  if [ $RES_M -gt 0 ]; then
    printf "%-30s  Disabled\n" $NAME
  else
    printf "%-30s  Enabled\n" $NAME
  fi
}

check_range()         
{                  
  NAME=$1                  
  BASE=$2                   
  OFF=$3                                   
  SBIT=$4                             
  EBIT=$5
  MASK=0   
  for i in $(seq $SBIT $EBIT); do
    TMASK=$((1 << i));
    MASK=$(($MASK + $TMASK))
  done   
         
  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)  
  RES_M=$(($RES & $MASK))
  RES=$(($RES_M >> $SBIT))
  printf "%-30s  = 0x%08X\n" $NAME $RES 
}                          


xsi_dbg()
{
  NAME=$1
  BASE=$2

  echo "XSI MAC debug cnt: $NAME"

  reg_c1 TX_OCTETS_CNT $BASE 0x104
  reg_c2 TX_PKT_CNT $BASE 0x108
  reg_c1 TXMBI_ETH_CNT $BASE 0x114
  reg_c2 TXMBI_UCETH_CNT $BASE 0x118
  seg_c1 TXMBI_MCETH_CNT $BASE 0x11C 0
  seg_c2 TXMBI_BCETH_CNT $BASE 0x11C 16
  seg_c1 TXMBI_PAUSEON_CNT $BASE 0x120 0
  seg_c2 TXMBI_PAUSEOFF_CNT $BASE 0x120 16
  reg_c1 TX_BYTES_CNT $BASE 0x134
  reg_c2 TX_NORMAL_PKT_BYTES_CNT $BASE 0x138

  reg_c1 RX_FRAME_CNT $BASE 0x180
  reg_c2 RX_OCTETS_CNT $BASE 0x184 
  reg_c1 RX_PKT_CNT $BASE 0x188
  reg_c2 RX_ETH_CNT $BASE 0x18C
  seg_c1 RX_PAUSEON_CNT $BASE 0x190 0
  seg_c2 RX_PAUSEOFF_CNT $BASE 0x190 16
  seg_c1 RX_LENERR_CNT $BASE 0x194 0
  seg_c2 RX_FRAGERR_CNT $BASE 0x194 16
  seg_c1 RX_CRCERR_CNT $BASE 0x198 0 
  seg_c2 RX_CODINGERR_CNT $BASE 0x198 16
  reg_c1 RXMBI_ETH_CNT $BASE 0x19C  
  seg_c2 RXMBI_ERRDROP_CNT $BASE 0x1A0 0
  seg_c1 RXMBI_SOFDROP_CNT $BASE 0x1A0 16
  seg_c2 RX_SOF_CNT $BASE 0x1A4 0
  seg_c1 RX_EOF_CNT $BASE 0x1A4 16
  seg_c2 RX_MPI_SOP_CNT $BASE 0x1A8 0
  seg_c1 RX_MPI_SOP_CNT $BASE 0x1A8 16
  reg_c2 RX_NORMAL_PKT_BYTES_CNT $BASE 0x1AC
  seg_c1 RX_MBI_SOP_CNT $BASE 0x1B8 0
  seg_c2 RX_MBI_EOP $BASE 0x1B8 16
  reg_c1 RX_UC_DROP_CNT $BASE 0x200
  reg_c2 RX_BC_DROP_CNT $BASE 0x204
  reg_c1 RX_MC_DROP_CNT $BASE 0x208
  reg_c2 RX_TOTAL_DROP_CNT $BASE 0x20C

  check_bit TX_FLOW_CTRL $BASE 0x0 5
  check_bit RX_FLOW_CTRL $BASE 0x0 4
  check_bit_i TX_MBI_ITF $BASE 0xCC 0
  check_bit_i TX_MPI_ITF $BASE 0xCC 1
  check_bit_i RX_MBI_ITF $BASE 0xCC 2
  check_bit_i RX_MPI_ITF $BASE 0xCC 3
  check_range TX_FRAG_LEN $BASE 0x0 17 21
  check_range RX_FRAG_LEN $BASE 0x0 22 26
}

case $1 in
        "7523_ae")
                xsi_dbg ae 0x1fa60000
                ;;
        "7523_pcie0")
                xsi_dbg pcie0 0x1fa70000
                ;;
        "7523_pcie1")
                xsi_dbg pcie1 0x1fa71000
                ;;
        "7523_usb3")
                xsi_dbg usb3 0x1fa80000
                ;;
        "7581_ae" | "7583_ae")
                xsi_dbg ae 0x1fa08000
                ;;
        "7581_eth" | "7583_eth")
                xsi_dbg eth 0x1fa09000
                ;;
        "7581_pcie0" | "7583_pcie")
                xsi_dbg pcie0 0x1fa04000
                ;;
        "7581_pcie1" | "7583_usb")
                xsi_dbg pcie1 0x1fa05000
                ;;
        "7581_usb3")
                xsi_dbg usb3 0x1fa07000
                ;;
esac
