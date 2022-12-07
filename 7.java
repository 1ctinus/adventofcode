// this was, by far, the hardest one so far. I tried doing it in haskell but i needed something with strong string functions.
public class MyClass {
    public static void main(String args[]) {
    String data = args[0].replace("$ cd ..", "BACK");
    int index = data.indexOf("$ cd");
    int outp = 70000000;
    while (index >= 0) {
        int end = 1;
        int i = index + 1;
        while(i < data.length()-5 && end != 0){
            if(data.substring(i, i+4).equals("BACK")){
            end -= 1;
            }
            if(data.substring(i, i+4).equals("$ cd")){
            end += 1;
            }
            i++;
        }

        String numss[] = (data.substring(index, i).replaceAll("[^0-9 ]","").replaceAll(" +", " ")).split(" ");
        int determine = 0;
        for(int j = 0; j < numss.length; j++){
            if(!numss[j].equals("")){
            determine += Integer.parseInt(numss[j]);
            }
        }
        System.out.println(determine);
        if(determine >= 4359867 && determine <= outp){
         outp = determine;
        }
        index = data.indexOf("$ cd", index + 1);
    }
    System.out.println(outp);
    }
    
}
