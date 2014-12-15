class Sudoku
  
  def info
    puts "Sudoku Solver reades Sudoku from a .csv file and solves it"  
    puts "Trying to take json as input File for Sudoku or to create json file out of csv file to "
    puts "make lines, blocks and colums and to connect them in between"
  end
  
  def initialize
   @ref_grid=(1..9).to_a+(11..19).to_a+(21..29).to_a+(31..39).to_a+(41..49).to_a+(51..59).to_a+(61..69).to_a+(71..79).to_a+(81..89).to_a    # reference Array for addressing individual elements
   @solution_hash=Hash[*@ref_grid.map{|v| [v,[0]]}.flatten] #creates a hash with the keys are the 
   @ref_array=[(1..9).to_a,(11..19).to_a,(21..29).to_a,(31..39).to_a,(41..49).to_a,(51..59).to_a,(61..69).to_a,(71..79).to_a,(81..89).to_a]
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
   # puts @solution_hash
   # puts @all_fields.flatten.inspect
   # puts @all_fields.inspect
   end
      
  def show #puts out the all_fields array one element below each other, so that you can see the sudoku in a grid
    puts " For seeing the Sudoku enter 1 \n For seeing the reference Array enter 2!"
    val = gets.chomp
    if val=="1"
    @all_fields.each{|y| puts y.inspect}
    # puts @all_fields.flatten.length
    elsif val=="2"
      @ref_array.each{|y| puts y.inspect}
   # puts @ref_array.flatten.length
    else puts "ERROR in method Definition invalid Input"
  end  
  
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
      @ref_block =@ref_array[0..2].collect {|x|  x[0..2]}
     # @block_called=[ @all_fields[0][0],@all_fields[0][1],@all_fields[0][2],@all_fields[1][0],@all_fields[1][1],@all_fields[1][2],@all_fields[2][0],@all_fields[2][1],@all_fields[2][2],]
      # print @block_called.inspect
    elsif block_addr==2 #middle left submatrix
      @block_called =@all_fields[3..5].collect {|x|  x[0..2]}
      @ref_block =@ref_array[3..5].collect {|x|  x[0..2]}
      # print @block_called.inspect 
    elsif block_addr==3 #lower left submatrx
      #print block_addr
      @block_called= @all_fields[6..8].collect {|x|  x[0..2]}
      @ref_block =@ref_array[6..8].collect {|x|  x[0..2]}
      # print @block_called.inspect + " Block method 3"
    elsif  block_addr==4 #upper middle submatrix--
      @block_called = @all_fields[0..2].collect {|x|  x[3..5]}
      @ref_block =@ref_array[0..2].collect {|x|  x[3..5]}
      # print @block_called.inspect+ " Block method 4"
    elsif  block_addr==5 # middle middle submatrix
      @block_called = @all_fields[3..5].collect {|x|  x[3..5]}
      @ref_block =@ref_array[3..5].collect {|x|  x[3..5]}
      # print @block_called.inspect+ " Block method 5"
    elsif  block_addr==6 #lower middle submatrix
      @block_called = @all_fields[6..8].collect {|x|  x[3..5]}
      @ref_block =@ref_array[6..8].collect {|x|  x[3..5]}
      # print @block_called.inspect+ " Block method 6"
    elsif  block_addr==7 #upper right submatrix
      @block_called = @all_fields[0..2].collect {|x|  x[6..8]} 
      @ref_block =@ref_array[0..2].collect {|x|  x[6..8]}
      # print @block_called.inspect+ " Block method 7"
    elsif  block_addr==8 #middle right submatrix
      @block_called = @all_fields[3..5].collect {|x|  x[6..8]}
      @ref_block =@ref_array[3..5].collect {|x|  x[6..8]}
      # print @block_called.inspect+ " Block method 8"
    elsif  block_addr==9 #lower right submatrix
      @block_called = @all_fields[6..8].collect {|x|  x[6..8]}
      @ref_block =@ref_array[6..8].collect {|x|  x[6..8]}
      print @block_called.inspect    
    else puts "ERROR!"    
    end
    return @block_called, @ref_block  
  end #take_block
  
  def get_line(line_addr) #gets 'line_addr' line and stores in @this_line
    @this_line = @all_fields[line_addr]
    @ref_line = @ref_grid[line_addr]
    return @this_line, @ref_line
  end #get_line

  def get_column(column_addr)  # gets column at column_addr and stores in @this_column
    @this_column = @all_fields.collect{|x| x[column_addr]}
    @ref_column = @ref_array.collect{|y| y[column_addr]}
    return @this_column, @ref_column
  end #def get column
  
###############################################
#                                             #
#   Function for solving the Sudoku           #
#                                             # 
###############################################
def solve
  puts "Now solve"
  @ncs=1 #  ncs = number_current_solved; the function is solving for each number in one loop
 # 1.upto(9) do  #loop over all 9 numbers
    # getting solution for one numer for one block
    #  @all_fields[@ncs][@ncs] = 780 taking changes in Sudoku grid
    #  puts take_block(@ncs)[0].inspect + "Take Block Line 125"         
       current_block , cur_ref_block = take_block(@ncs) #[1].to_a #.self current_block 
    if current_block.flatten.include?("@ncs")==true #CHANGE: force to get in else-part
      puts "#{@ncs} current_block if"
    elsif
      # here check lines here
     # puts "#{@ncs} current_block else"
      if @ncs==1||@ncs==4||@ncs==7  #check lines of Blocks 1,4,7 (upper lines column)
      puts "Block 1/4/7" 
      current_line = get_line(0).to_a
      puts current_line.inspect
      puts current_line[0].include?(2).to_s + " include"
        if current_line[0].include?(2)==true # CHANGE 2 --> @ncs
          puts current_block.inspect + " block davor"
          puts cur_ref_block.inspect + " davro ref"
          current_block.delete_at(1)
          cur_ref_block.delete_at(1)
          puts current_block.inspect + "current block 0"
          puts cur_ref_block.inspect + "current ref block"
        end
        current_line = get_line(1).to_a
       # puts get_line(1)[0].to_s + " hier Get line"
        if get_line(1).include?(@ncs)==true  
          current_block.delete(1)
          cur_ref_block.delete(1)
         puts     "Zeile 141"     # current_block.class + "current block 1"
        end
         current_line = get_line(2).to_a
        if get_line(2)[0].include?(@ncs)==true
          current_block.delete(2)
          cur_ref_block.delete(2)
          puts "Zeile 146" # current_block + "current block 2"
        end
      elsif @ncs==2||@ncs==5||@ncs==8 # check lines for middle Block
       current_line = get_line(3).to_a
        if current_line[0].include?(@ncs)==true 
          current_block.delete(0)
          cur_ref_block.delete(0)
          puts "Zeile 152 " + current_block.inspect.to_s + " current block 3"
        end
        current_line = get_line(4).to_a
        if get_line(4)[0].include?(@ncs)==true
          current_block.delete(1)
          cur_ref_block.delete(1)
         puts "Zeile 157" + current_block.inspect #+ "current block 4"
        end
        print get_line(5)[0].inspect + " get_line class 11"
         current_line = get_line(5)[0]
        if get_line(5)[0].include?(@ncs)==true
          current_block.delete(2)
          cur_ref_block.delete(2)
         # puts current_block.inspect + "current block 5"
        end
      elsif @ncs==3||@ncs==6||@ncs==9 # check lines for bottom Blocks
      #puts "Blocks 3 ,6 und 9"
      current_line = get_line(6)[0].to_a
        if current_line[0].include?(@ncs)==true 
          current_block.delete(0)
          cur_ref_block.delete(0)
         puts current_block + " current block 6"
        end
        current_line = get_line(7).to_a
        if get_line(8)[0].include?(@ncs)==true
          current_block.delete(1)-
          cur_ref_block.delete(1)
          puts current_block + " current block 7"
        end
         current_line = get_line(8).to_a
        if get_line(8)[0].include?(@ncs)==true
          current_block.delete(2)
          cur_ref_block.delete(2)
          puts current_block + " current block 8"
        end
      end
    # check columns if they contain ncs (= number solved for)
     puts current_block  +" cur block"
     puts cur_ref_block  +" ref block"    
    end # end of if block for checking for ncs = number solved for in current block
    current_block = current_block.delete_at(1)
    @ncs += 1 #increases for the next number to solve
   
 # end #loop over 1.upto 9
end #function solve
  
end # End Sudoku Class

test = Sudoku.new
test.read("Sudoku1.csv")
# puts test.get_column(2).inspect
#test.show
test.solve

#a,b = test.take_block(1)
#puts a.class # +" (Klasse)"
#puts a.inspect # +"inspect"
#puts b.class # +" Klasse"
#puts b.inspect# +" inspect"
