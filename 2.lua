them = 0
me = 0
output = 0
for i=1,string.len(arg[1]),4 do
  if(arg[1]:sub(i,i) == "A")
  then
    them = 1
  elseif(arg[1]:sub(i,i) == "B")
  then
    them = 2
  elseif(arg[1]:sub(i,i) == "C")
  then
    them = 3
  else
  end
  if(arg[1]:sub(i+2,i+2) == "X")
  then
  me = them - 1
    if(them == 1)
    then me = 3
    end
  elseif(arg[1]:sub(i+2,i+2) == "Y")
  then
  me = them
  output = output + 3
  elseif(arg[1]:sub(i+2,i+2) == "Z")
  then
  me = (them)%3+1
  output = output + 6
  else
  end
  output = output + me
end
print(output)
