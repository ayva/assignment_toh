require "pry"
require 'byebug'

class TowerOfHanoi
  
  def initialize(tower_height)
    @towers=tower_height
  end
  

  def play
    puts "Welcome to Tower of Hanoi!"
    puts "Instructions:"
    puts "Enter where you'd like to move from and to"
    puts "in the format [1,3]. Enter 'q' to quit."
    puts "Current Board:"

    
    
    game_loop
    

  end

  def game_loop
    # finishes when the user either quits or wins
    
    rods=Hash.new()
    rods[1]=Array(1..@towers+1).reverse
    rods[2]=[@towers+1]
    rods[3]=[@towers+1]

    movement=[]
    
    while !game_over?(movement,rods)
      render(rods)
      movement=ask

      if movement=="q"
        return
      end
      
      move(movement,rods)
      

      if victorious?(rods)
        puts "Congratulations! You won!"
        render(rods)
      end
    end
  end
  
  def ask
    puts "Enter move >"
    movement=[]
    arr=gets.chomp

    if quit?(arr) 
      return "q"
    end
      
    arr=arr.split("")
    movement << arr[1].to_i
    movement << arr[3].to_i
    
    movement
  end

  def input_check?(movement)
    movement[0].between?(0,4) && movement[1].between?(0,4) ? true : false
  end

  def render(rods)
    
    
      for index in Array(1..@towers).reverse
        rods.keys.each do |key|
          if rods[key][index]!=nil 
            print "#{" "*3}#{"O"*rods[key][index]+" "*(@towers+3-rods[key][index])}" 
          else
            print "#{" "*(3)+" "*(@towers+3)}" 
          end
        end

        puts " "
      end

    rods.keys.each do |key|
      print "#{" "*(3)}#{key}#{"-"*(@towers+2)}"
    end

    puts
  end

  def move (movement,rods)
    if input_check?(movement)
      
      if rods[movement[0]].last==4
        puts "There is no disk to move on this rod"
      elsif rods[movement[0]].last < rods[movement[1]].last 
        
        rods[movement[1]]<<rods[movement[0]].pop 
      else 
        puts "No disk may be placed on top of a smaller disk."
      end

    else
      puts "Only number of rods from 1 to 3 acceptable."
    end
  end  

  def game_over?(movement,rods)
    victorious?(rods) || quit?(movement)
  end

  def victorious?(rods)
    # check for victory, return true/false
    rods[3]==[(@towers+1),3,2,1] ? true : false
  end

  def quit?(movement)
    # check for loss, return true/false
    movement=="q" ? true : false
  end

end






