// doesn't have a parser, sorry man
inp.push([[2]]);
inp.push([[6]])
let shouldexit = false;
let outp = true;
function processArray(left, right){
  if(!shouldexit){
console.log("compare"+ JSON.stringify(left), JSON.stringify(right))
  for(let a = 0; a < Math.max(right.length, left.length) && !shouldexit; a++){
    if(a === left.length){
      console.log("LEFT SIDE RAN OUT OF ITEMS SO TRUE")
      shouldexit = true;
      outp = true;
      break;
   }
  else if(a === right.length){
    console.log("RIGHT SIDE RAN OUT OF ITEMS SO FALSE")
    shouldexit = true;
    console.log(right[a])
   outp = false
    break;
   }
   else if(!Array.isArray(left[a]) && !Array.isArray(right[a])){
       console.log("COMPARE",left[a], right[a])
       if(left[a] > right[a]){
           console.log("RIGHT SIDE IS SMALLER SO FALSE")
           outp = false;
         shouldexit = true;
           break;
       } else if(left[a] < right[a]){
       console.log("LEFT SIDE IS SMALLER SO TRUE")
        outp = true;
        shouldexit = true;
         break;
       }
   }
   else if(Array.isArray(left[a]) && Array.isArray(right[a])){
      console.log(a)
    processArray(left[a],right[a])
   }
    else if(Array.isArray(left[a]) && !Array.isArray(right[a])){
      console.log(a)
      processArray(left[a] , [right[a]])  
  }
    else if(!Array.isArray(left[a]) && Array.isArray(right[a])){
      console.log(a)
    processArray([left[a]] ,right[a])   
   }
    else {console.log("WTF?")}
 }
}
}


var sorted = inp.sort(function (a,b){shouldexit = false; processArray(a,b); return outp ? -1 : 0})
for(let i = 0; i < sorted.length; i++){
    if(sorted[i].length === 1){
        if(sorted[i][0].length === 1 && sorted[i][0][0] === 6){
            console.log(i+1 + "A")
        }
                if(sorted[i][0].length === 1 && sorted[i][0][0] === 2){
            console.log(i+1)
        }
    }
}
