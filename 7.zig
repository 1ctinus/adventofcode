const std = @import("std");
pub fn main() !void {
  var gpa = std.heap.GeneralPurposeAllocator(.{}){};
  var allocator = gpa.allocator();
  var foo = @embedFile("7zig.txt"); // in the format of a single line
  var data = try std.mem.replaceOwned(u8, allocator, foo, "cd ..", "BACK");
  var index = std.mem.indexOf(u8, data, "$ cd");
  var outp: u64 = 70000000;
  while (index != null) {
    var end: u64 = 1;
    var i: u64 = index.? + 1;
    while (i < data.len - 5 and end != 0) {
      if (std.mem.eql(u8, data[i .. i + 4], "BACK")) {
        end -= 1;
      }
      if (std.mem.eql(u8, data[i .. i + 4], "$ cd")) {
        end += 1;
      }
        i += 1;
      }
      var numss = std.mem.split(u8, data[index.?..i], " ");
      var determine: u64 = 0;
      while (numss.next()) |token| {
        var parsed: u64 = std.fmt.parseInt(u64, token, 10) catch 0;
        determine = determine + parsed;
      }
      if (determine >= 4359867 and determine <= outp) {
        outp = determine;
      }
      var newpoint = std.mem.indexOf(u8, data[index.? + 1 ..], "$ cd");
      if (newpoint != null) {
        index = newpoint.? + index.? + 1;
       } else {
         index = null;
      }
    }
    std.debug.print("{}", .{outp});
}
