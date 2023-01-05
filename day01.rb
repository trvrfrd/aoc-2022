input_path = File.expand_path("input_day01.txt", File.dirname(__FILE__))
input = File.read(input_path)

elf_inventories = input.split(/\n\n/)
elf_inventories.map! do |inv|
  inv.split(/\n/).map(&:to_i)
end

# part 1
# expected: 72240
puts elf_inventories.map(&:sum).max

# part 2
# expected: 210957

# the too easy way:
# puts elf_inventories.map(&:sum).max(3).sum

# the slightly harder way:
three_most_laden_elves = [0, 0, 0]

elf_inventories.each do |inv|
  this_elf_load = inv.sum
  three_most_laden_elves = (three_most_laden_elves << this_elf_load).max(3)
end

puts three_most_laden_elves.sum
