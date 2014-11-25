class Sudoku
   
#getting a Sudoku from a file
  def read (filename)    
    rest = File.open("#{filename}","r") #opens sudoku from file in read mode
feld = rest.readlines  # reads each line as String in Array
t=0   # variable used in loop downwards
all_fields = Array.new #sets new array to put Sudoku in as Fixnum
feld = feld.collect! do |x| #loop over lines of file
part_line = feld[t].split(";") # splits each line and stores in part_line as string numbers
part_line.delete("\n") #deletes line break
part_line.collect!{|t| t.to_i} #formats each number as string to a fixnum and 0 for empty spaces
all_fields[t]=part_line #stores each line now as array of numbers in the new Sudoku field 
  t+=1 # increases iterater      
end
@all_fields = all_fields
  end
  
def show #puts out the all_fields array one element below each other, so that you can see the sudoku in a grid
  @all_fields.each{|y| puts y.inspect}
end  
  
def get_block
  puts "Which Block?"
  puts " [1 2 3] \n [4 5 6] \n [7 8 9]"
  block_addr = gets.chomp
  take_block(block_addr)
end  

def take_block(block_addr=0)
 puts @all_fields[0][0]
 puts @all_fields[1][0]
 puts @all_fields[2][0]
 puts @all_fields[1][4]
end
def get_line(line_addr) #gets 'line_addr' line and stores in @this_line
	@this_line = @all_fields[line_addr]
  print @this_line
end

def get_column(column_addr)  # gets column at column_addr and stores in @this_column
  @this_column = @all_fields.collect{|x| x[column_addr]}
  puts @this_column

end
end
hier = Sudoku.new
hier.read("Sudoku1.csv")
hier.show
hier.take_block
