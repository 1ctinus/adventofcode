fn main() {
let foo = "the input data";
let mut max : i32 = 0;
let mut two : i32 = 0;
let mut three : i32 = 0;
let mut cache : i32 = 0;
for elf in foo {
    let nums = elf.split("\n");
        for num in nums {
        cache += num.parse::<i32>().unwrap();
    }
    if cache > max{
    three = two;
    two = max;
     max = cache;
    } else if cache > two{
        three = two;
        two = cache;
    } else if cache > three {
        three = cache;
    }
    cache = 0;
}
    println!("{}",three+two+max);
}
