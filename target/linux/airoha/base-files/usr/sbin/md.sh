DN=$(echo $(($1)))
RANGE=$2
i=0

while [ $i  -lt  $RANGE ]
do
   CV1=$(devmem $DN)
   RA=$DN
   DN=`expr $DN + 4`
   CV2=$(devmem $DN)
   DN=`expr $DN + 4`
   CV3=$(devmem $DN)
   DN=`expr $DN + 4`
   CV4=$(devmem $DN)
   DN=`expr $DN + 4`

   CV5=$(devmem $DN)
   DN=`expr $DN + 4`
   CV6=$(devmem $DN)
   DN=`expr $DN + 4`
   CV7=$(devmem $DN)
   DN=`expr $DN + 4`
   CV8=$(devmem $DN)
   DN=`expr $DN + 4`


   x=`printf "[0x%04X]\n"  $RA`
   echo "$x $CV1 $CV2 $CV3 $CV4 $CV5 $CV6 $CV7 $CV8"
   i=`expr $i + 1`
done

