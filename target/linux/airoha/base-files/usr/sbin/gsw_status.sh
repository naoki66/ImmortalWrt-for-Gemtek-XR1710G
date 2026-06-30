get_port_info()
{
  PORT=$1
  ADDR=$2

  printf "\n[ Port %s ]\n" $1

  RUP=$(($ADDR | 0x68))
  RMP=$(($ADDR | 0x6C))
  RES1=$(devmem $RUP)
  RES2=$(devmem $RMP)
  printf "Rx Unicast Pkts        = 0x%08X, Rx Multicast Pkts      = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x70))
  V2=$(($ADDR | 0x74))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Rx Broadcast Pkts      = 0x%08X, Rx Align Error         = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x78))
  V2=$(($ADDR | 0x7C))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Rx CRC Error           = 0x%08X, Rx Under Size Pkts     = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x80))
  V2=$(($ADDR | 0x84))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Rx Fragment Error      = 0x%08X, Rx Over Size Pkts      = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x88))
  V2=$(($ADDR | 0x8C))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Rx Jabber Error        = 0x%08X, Rx Pause Pkts          = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x60))
  V2=$(($ADDR | 0xB4))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Rx Drop Pkts           = 0x%08X, Rx ING Drop Pkts       = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0xB8))
  V2=$(($ADDR | 0x64))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Rx ARL Drop Pkts       = 0x%08X, Rx FILTER Drop Pkts    = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0xB0))
  V2=$(($ADDR | 0xA8))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Rx CTRL Drop Pkts      = 0x%08X, Rx Octet Counter       = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x08))
  V2=$(($ADDR | 0x0C))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Tx Unicase Pkts        = 0x%08X, Tx Multicast Pkts      = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x10))
  V2=$(($ADDR | 0x14))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Tx Broadcast Pkts      = 0x%08X, Tx Collision           = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x18))
  V2=$(($ADDR | 0x1C))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Tx Single Collision    = 0x%08X, Tx Multiple Collision  = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x20))
  V2=$(($ADDR | 0x24))
  RES1=$(devmem $V1)
  RES2=$(devmem $V2)
  printf "Tx Defer               = 0x%08X, Tx Late Collision      = 0x%08X\n" $RES1 $RES2

  V1=$(($ADDR | 0x128))                                                                  
  V2=$(($ADDR | 0x12C))                                                                  
  RES1=$(devmem $V1)  
  RES2=$(devmem $V2)  
  printf "Tx eXcessive Collision = 0x%08X, Tx Pause Pkt           = 0x%08X\n" $RES1 $RES2
                                                                                         
  V1=$(($ADDR | 0x00))                                                                   
  V2=$(($ADDR | 0x48))                                                                   
  RES1=$(devmem $V1)   
  RES2=$(devmem $V2)   
  printf "Tx Drop Pkts           = 0x%08X, TX Octet Counter       = 0x%08X\n" $RES1 $RES2

}

#get_port_info 0 0x1FB5C000
get_port_info 1 0x1FB5C100
get_port_info 2 0x1FB5C200
get_port_info 3 0x1FB5C300
get_port_info 4 0x1FB5C400
#get_port_info 5 0x1FB5C500
get_port_info 6 0x1FB5C600
