ravr()
{
  REG=$1
  ADDR=$2
  
  RES=$(devmem $ADDR)
  printf "%-30s (%-10s) = %-8s\n" $REG $ADDR $RES
}

echo "PSE_DROP_CNT:"
PDC0=$(devmem 0x1FB50120)
PDC1=$(devmem 0x1FB50124)
PDC2=$(devmem 0x1FB50128)
PDC3=$(devmem 0x1FB5012C)
PDC4=$(devmem 0x1FB50130)
PDC5=$(devmem 0x1FB50134)
PDC6=$(devmem 0x1FB50138)
PDC7=$(devmem 0x1FB5013C)
PDC8=$(devmem 0x1FB50140)
PDC9=$(devmem 0x1FB50144)
echo "P0:$PDC0  P1:$PDC1  P2:$PDC2  P3:$PDC3"
echo "P4:$PDC4  P5:$PDC5  P6:$PDC6  P7:$PDC7"
echo "P8:$PDC8  P9:$PDC9"

printf "PSE_IQ_CNT:    "
PPP0=$(devmem 0x1FB50150)
PPP1=$(devmem 0x1FB50154)
PPP2=$(devmem 0x1FB50158)
PPP3=$(devmem 0x1FB5015C)
PPP4=$(devmem 0x1FB50160)
PPP5=$(devmem 0x1FB50164)
PPP6=$(devmem 0x1FB50168)
PPP7=$(devmem 0x1FB5016C)
PPP8=$(devmem 0x1FB50170)
PPP9=$(devmem 0x1FB50174)
printf "P0: 0x%02X" $(($PPP0 >> 16))
printf " P1: 0x%02X" $(($PPP1 >> 16))
printf " P2: 0x%02X" $(($PPP2 >> 16))
printf " P3: 0x%02X" $(($PPP3 >> 16))
printf " P4: 0x%02X" $(($PPP4 >> 16))
printf " P5: 0x%02X\n" $(($PPP5 >> 16))
printf "               P6: 0x%02X" $(($PPP6 >> 16))
printf " P7: 0x%02X" $(($PPP7 >> 16))
printf " P8: 0x%02X" $(($PPP8 >> 16))
printf " P9: 0x%02X\n" $(($PPP9 >> 16))

printf "PSE_OQ_CNT:    "
printf "P0: 0x%02X" $(($PPP0 & 0xFFFF))
printf " P1: 0x%02X" $(($PPP1 & 0xFFFF))
printf " P2: 0x%02X" $(($PPP2 & 0xFFFF))
printf " P3: 0x%02X" $(($PPP3 & 0xFFFF))
printf " P4: 0x%02X" $(($PPP4 & 0xFFFF))
printf " P5: 0x%02X\n" $(($PPP5 & 0xFFFF))
printf "               P6: 0x%02X" $(($PPP6 & 0xFFFF))
printf " P7: 0x%02X" $(($PPP7 & 0xFFFF))
printf " P8: 0x%02X" $(($PPP8 & 0xFFFF))
printf " P9: 0x%02X\n" $(($PPP9 & 0xFFFF))

PSB=$(devmem 0x1FB50104)
printf "PSE_SHARE_BUF:  SHARED_USED_CNT: 0x%04X" $(($PSB >> 16))
printf "  SHARED_FREE_CNT: 0x%04X\n" $(($PSB & 0x7FFF))

printf "\n"

ravr "GDM1_TX_GET_CNT  " 0x1fb50600
ravr GDM1_TX_OK_CNT_L 0x1fb50604
ravr GDM1_TX_OK_CNT_H 0x1fb50780
ravr GDM1_TX_DROP_CNT         0x1fb50608
ravr GDM1_TX_BYTE_CNT         0x1fb50614
ravr "GDM1_RX_OK_CNT    "       0x1fb50648
ravr GDM1_RX_FC_DROP_CNT      0x1fb5064c
ravr GDM1_RX_RC_DROP_CNT      0x1fb50650
ravr GDM1_RX_OVER_DROP_CNT    0x1fb50654
ravr GDM1_RX_ERROR_DROP_CNT   0x1fb50658

ravr CDMA1_TX_OK_CNT           0x1fb50580
ravr CDMA1_RXCPU_OK_CNT        0x1fb50590
ravr CDMA1_RXHWF_OK_CNT        0x1fb50594
ravr CDMA1_RXHWF_FAST_OK_CNT   0x1fb50598
ravr CDMA1_RXCPU_DROP_CNT      0x1fb505a0
ravr CDMA1_RXHWF_DROP_CNT      0x1fb505a4
ravr CDMA1_RXHWF_FAST_DROP_CNT 0x1fb505a8

ravr GDMA1_TX_GET_CNT          0x1fb50600
ravr GDMA1_TX_OK_CNT_L         0x1fb50604
ravr GDMA1_TX_OK_CNT_H         0x1fb50780
ravr GDMA1_TX_DROP_CNT         0x1fb50608
ravr GDMA1_RX_OK_CNT           0x1fb50648
ravr GDMA1_RX_FC_DROP_CNT      0x1fb5064c
ravr GDMA1_RX_RC_DROP_CNT      0x1fb50650
ravr GDMA1_RX_OVER_DROP_CNT    0x1fb50654
ravr GDMA1_RX_ERROR_DROP_CNT   0x1fb50658

ravr CDMA2_TX_OK_CNT           0x1fb51580
ravr CDMA2_RXCPU_OK_CNT        0x1fb51590
ravr CDMA2_RXHWF_OK_CNT        0x1fb51594
ravr CDMA2_RXHWF_FAST_OK_CNT   0x1fb51598
ravr CDMA2_RXCPU_DROP_CNT      0x1fb515a0
ravr CDMA2_RXHWF_DROP_CNT      0x1fb515a4
ravr CDMA2_RXHWF_FAST_DROP_CNT 0x1fb515a8

ravr GDMA2_TX_GETCNT           0x1fb51600
ravr GDMA2_TX_OKCNT_L          0x1fb51604
ravr GDMA2_TX_OKCNT_H          0x1fb51780
ravr GDMA2_TX_DROPCNT          0x1fb51608
ravr GDMA2_RX_OKCNT            0x1fb51648
ravr GDMA2_RX_FCDROPCNT        0x1fb5164c
ravr GDMA2_RX_RCDROPCNT        0x1fb51650
ravr GDMA2_RX_OVDROPCNT        0x1fb51654
ravr GDMA2_RX_ERRDROPCNT       0x1fb51658
