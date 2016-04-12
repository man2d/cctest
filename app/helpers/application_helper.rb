module ApplicationHelper

  def something(a,b,c,d,e,f,g,h)
   @badCodeSmells = 1
   #We automatically generated one or more configuration files for this repo. You can download this configuration to customize it

   a = [
[1,2,3]
]
  end

def sort
  board = [[nil,nil,nil],
         [nil,nil,nil],
         [nil,nil,nil]]

players = [:X, :O].cycle

loop do
  current_player = players.next
  puts board.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
  print "\n>> "
  row, col = gets.split.map { |e| e.to_i }
  puts
  board[row][col] = current_player
end

end
end
