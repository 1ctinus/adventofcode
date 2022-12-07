program sum
  character(9999) :: s
  integer(4) :: them
  integer(4):: me
  integer(4) :: outp
  outp = 0
  me = 0
  them = 0
  read*, s
    do i = 1, 9999, 4
      if (s(i:i) == "A") then
      them = 1
      else if (s(i:i) == "B") then
      them = 2
      else if (s(i:i) == "C") then
      them = 3
      end if
      if (s(i+2:i+2) == "X") then
      me = them - 1
        if(them == 1) then 
          me = 3 
        end if
      else if (s(i+2:i+2) == "Y") then
      me = them
      outp = outp + 3
      else if (s(i+2:i+2) == "Z") then
      me = mod(them, 3) + 1
      outp = outp + 6
      end if
      outp = outp + me
    end do
    print*, outp
end program sum
