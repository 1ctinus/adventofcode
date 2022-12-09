#!/bin/sh
#this is the slowest code you'll ever see. it takes 15 mintues to complete. 
# speed it up by running it in busybox and dash, it is SH compatible
posx="0_0_0_0_0_0_0_0_0_0"
posy="0_0_0_0_0_0_0_0_0_0"
positions="0+0\n"
parsedata() {
direction=$(echo "$1"| cut -c 1)
amount=$(echo "$1"| cut -c 3-)
posy0=`echo "$posy" | cut -d'_' -f1`
posx0=`echo "$posx" | cut -d'_' -f1`
for i in $( seq 1 $amount); do
if [ "$direction" = "D" ]; then
 posy0=$((posy0-1))
elif [ "$direction" = "U" ]; then
 posy0=$((posy0+1)) 
elif [ "$direction" = "L" ]; then

  posx0=$((posx0-1)) 
elif [ "$direction" = "R" ]; then

  posx0=$((posx0+1)) 
fi
posx="${posx0}_`echo "$posx" | cut -d"_" -f2- `"
posy="${posy0}_`echo "$posy" | cut -d"_" -f2- `"
#echo one
for j in 1 2 3 4 5 6 7 8 9; do
  pasty=`echo "$posy" | cut -d'_' -f$((j))`
  pastx=`echo "$posx" | cut -d'_' -f$((j))`
  curry=`echo "$posy" | cut -d'_' -f$((j+1))`
  currx=`echo "$posx" | cut -d'_' -f$((j+1))`

  distx=$((pastx-currx))
  disty=$((pasty-curry))
  absdistx=$(($(echo "$distx" | cut -d"-" -f2 )))
  absdisty=$(echo "$disty"| cut -d"-" -f2 )
  if [ $((absdistx)) -gt 1 -a $((absdisty)) -gt 0 ] || [ $((absdistx)) -gt 0 -a $((absdisty)) -gt 1 ]; then

    currx=$((currx+distx/absdistx))
    curry=$((curry+disty/absdisty))
  elif [ $((absdistx)) -gt 1 ];then
    currx=$((currx+distx/absdistx))
  elif [ $((absdisty)) -gt 1 ]; then

    curry=$((curry+disty/absdisty))
  fi
  if [ $((j)) -eq 9 ]; then
   posx="$(echo "$posx" | cut -d"_" -f-9)_$currx"
    posy="$(echo "$posy" | cut -d"_" -f-9)_$curry"
  else
    posx="$(echo "$posx" |  cut -d"_" -f-$((j)))_${currx}_$(echo "$posx" |  cut -d"_" -f$((j+2))-)"
   posy="$(echo "$posy" |  cut -d"_" -f-$((j)))_${curry}_$(echo "$posy" |  cut -d"_" -f$((j+2))-)"
  fi

done
positions="${positions}$(echo "$posx"| cut -d'_' -f10)+$(echo "$posy"| cut -d'_' -f10)\\n"
done
return 0
}

while IFS= read -r line; do
  parsedata "$line"
done < 9.txt

echo $(printf "$positions" | sort | uniq | wc -l)
