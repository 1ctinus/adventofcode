using System;
using System.Text.RegularExpressions;
class AoC {
  static void Main(string[] args) {
    string data = args[0].Replace("cd ..", "BACK");
    int index = data.IndexOf("$ cd");
    int outp = 70000000;
    while (index >= 0) {
      int end = 1;
      int i = index + 1;
      while (i < data.Length - 5 && end != 0) {
        if (data.Substring(i, 4).Equals("BACK")) {
          end -= 1;
        }
        if (data.Substring(i, 4).Equals("$ cd")) {
          end += 1;
        }
        i++;
      }
      string[] numss = Regex.Replace(data.Substring(index, i - index), @"\s+", " ").Split(' ');
      int determine = 0;
      for (int j = 0; j < numss.Length; j++) {
        if (!numss[j].Equals("")) {
          int parsednumber;
          Int32.TryParse(numss[j], out parsednumber);
          determine += parsednumber;
        }
      }
      if (determine >= 4359867 && determine <= outp) {
        outp = determine;
      }
      index = data.IndexOf("$ cd", index + 1);
    }
    Console.WriteLine(outp);
  }
}
