(*yeah this code stinks but it's better then the rosetta code code, which doesn't work AT ALL*)
let () = 
  let string = "your string here" in
  for i = 0 to String.length string - 1 do
    let s = (String.sub string i 14) in
    let bad = ref false in
    for j = 0 to 13 do
      if List.length (String.split_on_char s.[j] s)  > 2 then bad := true
    done;
    if not !bad then print_endline(string_of_int(i + 14))
  done
