class Sudoku
  
  def info
    puts "Sudoku Solver reades Sudoku from a .csv file and solves it"       
  end
  
  def initialize
   @ref_grid=(1..9).to_a+(11..19).to_a+(21..29).to_a+(31..39).to_a+(41..49).to_a+(51..59).to_a+(61..69).to_+(71..79).to_a+(81..89).to_a    # reference Array for addressing individual elements
   @solution_hash=Hash[*@ref_grid.map{|v| [v,[0]]}.flatten] #creates a hash with the keys are the 
   # puts @ref_grid.inspect
   # puts @solution_hash.inspect
  end
  #addresses of the Sudoku and the values will become solution vectors for the Sudoku
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
        t+=1 # increases iterator      
      end
    @all_fields = all_fields
    @solution_hash=Hash[@ref_grid.zip @all_fields.flatten]
   # puts @ref_grid.zip
    puts @solution_hash
   # puts @all_fields.flatten.inspect
   puts @all_fields.inspect
      end
      
  def show #puts out the all_fields array one element below each other, so that you can see the sudoku in a grid
    @all_fields.each{|y| puts y.inspect}
    puts @all_fields.flatten.length
  end  
  
 
  
end

test = Sudoku.new
test.read("Sudoku1.csv")
test.show
