class Sudoku
   @@ref_grid=(0..81).to_a    # reference Array for addressing individual elements
   @@solution_hash=Hash[*arr.map{|v| [v,[0]]}.flatten] #creates a hash with the keys are the 
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
  end
  
  def show #puts out the all_fields array one element below each other, so that you can see the sudoku in a grid
    @all_fields.each{|y| puts y.inspect}
  end  
  
  def get_block # asks the user which submatrix to call and forwards it to the take_block method
    puts "Which Block?"
    puts " [1 4 7] \n [2 5 8] \n [3 6 9]"
    block_addr = gets.chomp.to_i
    take_block(block_addr)
  end  

  def take_block(block_addr) #takes out 1 of 9 specific a 3x3 sub matrices of the Sudoku
    if block_addr ==1 #upper left submatrix
      @block_called =@all_fields[0..2].collect {|x|  x[0..2]}
     # @block_called=[ @all_fields[0][0],@all_fields[0][1],@all_fields[0][2],@all_fields[1][0],@all_fields[1][1],@all_fields[1][2],@all_fields[2][0],@all_fields[2][1],@all_fields[2][2],]
      print @block_called.inspect
    elsif block_addr==2 #middle left submatrix
      @block_called =@all_fields[3..5].collect {|x|  x[0..2]}
      print @block_called.inspect 
    elsif block_addr==3 #lower left submatrx
      #print block_addr
      @block_called= @all_fields[6..8].collect {|x|  x[0..2]}
      print @block_called.inspect
    elsif  block_addr==4 #upper middle submatrix
      @block_called = @all_fields[0..2].collect {|x|  x[3..5]}
      print @block_called.inspect
    elsif  block_addr==5 # middle middle submatrix
      @block_called = @all_fields[3..5].collect {|x|  x[3..5]}
      print @block_called.inspect
    elsif  block_addr==6 #lower middle submatrix
      @block_called = @all_fields[6..8].collect {|x|  x[3..5]}
      print @block_called.inspect
    elsif  block_addr==7 #upper right submatrix
      @block_called = @all_fields[0..2].collect {|x|  x[6..8]} 
      print @block_called.inspect
    elsif  block_addr==8 #middle right submatrix
      @block_called = @all_fields[3..5].collect {|x|  x[6..8]}
      print @block_called.inspect
    elsif  block_addr==9 #lower right submatrix
      @block_called = @all_fields[6..8].collect {|x|  x[6..8]}
      print @block_called.inspect    
    else puts "ERROR!"    
    end
    return @block_called  
  end
  def get_line(line_addr) #gets 'line_addr' line and stores in @this_line
    @this_line = @all_fields[line_addr]
    return @this_line
  end

  def get_column(column_addr)  # gets column at column_addr and stores in @this_column
    @this_column = @all_fields.collect{|x| x[column_addr]}
    return @this_column
  end #def get column
 
###############################################
#                                             #
#   Function for solving the Sudoku           #
#                                             # 
###############################################
def solve
  puts "Now solve"
  @ncs=1 #  ncs = numbe_current_solved; the function is solving for each number in one loop
  1.upto(9) do  #loop over all 9 numbers
    # getting solution for one numer for one block
    #  @all_fields[@ncs][@ncs] = 780 taking changes in Sudoku grid
    current_block = take_block(@ncs).to_a #.self current_block
      puts current_block.class
    if current_block.flatten.include?("ncs")==true #zwang in else Schleife wieder rausnehmen (ändern)
      puts "#{@ncs} current_block if"
    elsif
      # here check lines here
     # puts "#{@ncs} current_block else"
      if @ncs==1||@ncs==4||@ncs==7  #check lines of Blocks 1,4,7 (upper lines column)
        current_line = get_line(0).to_a
        if current_line.include?(@ncs)==true 
          current_block.delete(0)
        end
        current_line = get_line(1).to_a
        if get_line(1).include?(@ncs)==true
          current_block.delete(1)
        end
         current_line = get_line(2).to_a
        if get_line(2).include?(@ncs)==true
          current_block.delete(2)
        end
      elsif @ncs==2||@ncs==5||@ncs==8 # check lines for middle Block
       current_line = get_line(3).to_a
        if current_line.include?(@ncs)==true 
          current_block.delete(0)
        end
        current_line = get_line(4).to_a
        if get_line(4).include?(@ncs)==true
          current_block.delete(1)
        end
         current_line = get_line(5).to_a
        if get_line(5).include?(@ncs)==true
          current_block.delete(2)
        end
      elsif @ncs==3||@ncs==6||@ncs==9 # check lines for bottom Blocks
      #puts "Blocks 3 ,6 und 9"
      current_line = get_line(6).to_a
        if current_line.include?(@ncs)==true 
          current_block.delete(0)
        end
        current_line = get_line(7).to_a
        if get_line(8).include?(@ncs)==true
          current_block.delete(1)
        end
         current_line = get_line(8).to_a
        if get_line(8).include?(@ncs)==true
          current_block.delete(2)
        end
      end
    # check columns if they contain ncs (= number solved for)
      puts current_block
    
    end # end of if block for checking for ncs = number solved for in current block
    current_block = current_block.delete_at(1)
    @ncs += 1 #increases for the next number to solve
  end #loop over 1.upto 9
end #function solve
end #Sudoku
#
#
####################################
#         Subclasses
####################################


class Block < Sudoku #creates a subclass for blocks from the Sudoku superclass with inheritance
   
 end
 
 class Line < Sudoku #creates a subclass for lines from the Sudoku superclass with inheritance
   
 end
 
 class Column_sud < Sudoku #creates a subclass for columns from the Sudoku superclass with inheritance
   
 end


hier = Sudoku.new
hier.read("Sudoku1.csv")
hier.show
# puts hier.class

hier.solve
