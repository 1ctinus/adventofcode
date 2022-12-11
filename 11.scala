import scala.collection.mutable.ListBuffer;
class Monkey(inp: String) {
  private var splitinp = inp.split('|')
  var operation = splitinp(2).split("= ")(1)
  var inspected = 0
  private var itemsS = splitinp(1).split("\\: ")(1).split("\\, ").map(_.toLong)
  var items: ListBuffer[Long] = ListBuffer(itemsS: _*)
  var test = splitinp(3).split("y ")(1).toInt
  var truemonkey = splitinp(4).split("y ")(1).toInt
  var falsemonkey = splitinp(5).split("y ")(1).toInt
  def runOperation(gcf: Int) = { // uses index not value
    val Oitems = operation.split(" ")
    var num1: Long = 0; var num2: Long = 0; var outp = 0: Long
    if (Oitems(0) == "old") { num1 = items(0) }
    else { num1 = Oitems(0).toLong }
    if (Oitems(2) == "old") { num2 = items(0) }
    else { num2 = Oitems(2).toLong }
    if (Oitems(1) == "*") { outp = num1 * num2 }
    else if (Oitems(1) == "+") { outp = num1 + num2 }
    // println (outp % gcf);
    items(0) = outp % gcf;
  }
}
object MyClass {
  var gcf = 0;
  def main(args: Array[String]): Unit = {
    val input = ""; //the input is split by tildes and whatever | is called 
    var monkeys = new Array[Monkey](input.length)
    monkeys(0) = new Monkey(input(0))
    gcf = monkeys(0).test
    for (a <- 1 until input.length) {
      monkeys(a) = new Monkey(input(a))
      gcf = gcf * monkeys(a).test

    }
    for (a <- 0 until 10000) {
      for (b <- 0 until monkeys.length) {
        while (monkeys(b).items.length != 0) {
          monkeys(b).inspected += 1
          monkeys(b).runOperation(gcf)
          if (monkeys(b).items(0) % monkeys(b).test == 0) {
            monkeys(monkeys(b).truemonkey).items += monkeys(b).items(0)
          } else {
            monkeys(monkeys(b).falsemonkey).items += monkeys(b).items(0)
          }
          monkeys(b).items.remove(0)
        }
      }
    }
    var one = 0;
    var two = 0;
    for (a <- 0 until monkeys.length) {
      if (monkeys(a).inspected > one) {
        one = monkeys(a).inspected
      } else if (monkeys(a).inspected > two) {
        two = monkeys(a).inspected
      }
    }
    println(one.toLong * two)
  }
}
