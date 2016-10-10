#
# Script that masks an ascii ppm (P3) image by an ascii pbm (P1) image
# scaled by 10 on each side (no interpolation)
#
# Author: David Koop (dkoop AT umassd DOT edu)
# Date: 9/28/2016
#

exec 4< "$1"

read -r ihead <&4
read -r isizex isizey <&4
read -r imax <&4

exec 5< "$2"

read -r mhead <&5
read -r msizex msizey <&5
read -r mcomment <&5

printf "P3\n$isizex $isizey\n255\n"

for((i=0;i<msizey;++i))
do
    values=()
    read -r -a values <&5
    for((ii=0;ii<10;++ii))
    do
	read -r -a iline <&4
	for((j=0;j<msizex;++j))
	do
	    if [ "${values[j]}" = "1" ]
	    then
		for((jj=0;jj<30;++jj))
		do
		    printf "${iline[j*30+jj]} "
		done
	    else
		for((jj=0;jj<30;++jj))
		do
		    printf "0 "
		done
	    fi
	done
	printf "\n"
    done
done
