Shoes.app(title: "Hangman", width: 500, height: 500, resizable: false) do
	background rgb(rand(255), rand(255), rand(255))


	$e = oval top: 30, left: 210, radius: 30
	$e.hide
				        	
	$f = rect 232, 60,  15, 150
	$f.hide
				        	
	rotate 45
	$g = rect 265, 75, 15, 100
	$g.hide

	rotate 90
	$h = rect 195, 75, 15, 100
	$h.hide
				    		
	rotate 75
	$i = rect 260, 195, 15, 100
	$i.hide
				      		
	rotate 115
	$k = rect 205, 195, 15, 100
	$k.hide

	def restart_game
		$a.remove
		$b.remove
		$d.remove
		$e.hide		
		$f.hide
		$g.hide
		$h.hide
		$i.hide
		$k.hide
		new_game()
	end


	def new_game
		file_data = File.read("dictionary.txt").split

		targetWord = file_data[rand(file_data.length()-1)].upcase!

		char = Hash.new
		wordChar = targetWord.split('')
		lives = 6
		cur_word = ""
		word_place = nil
		letter_used = []
		letter_place = nil

		wordChar.each{|c| 
		if c =~ /[A-Za-z]/
			char[c] = " _ "
		else
			char[c] = " #{c} "
		end}


		wordChar.each do |letter|
			cur_word += char[letter]
		end

		$a = stack margin_left: 10, margin_top: 10 do
			caption "Letters used"
			letter_place = para letter_used
		end

		$b = flow margin_left: 125, margin_top: 250 do
			word_place = para cur_word
		end

			
		
		quit = button "Quit"

		quit.move(400, 10)
		quit.click{
			exit
		}

		restart = button "Restart"
		restart.move(400, 40)



		$d = flow margin_left: 10, margin_top: 10 do
		    ('A'..'Z').each do |letter|
		        button letter, width: 40, height: 30, align: "center"  do

		        	cur_word = ""
		          		
		          	if wordChar.include? letter and char[letter] == " _ "
						char[letter] = " #{letter} "
							
						wordChar.each do |letter|
			    			cur_word += char[letter]
			    		end

						word_place.replace cur_word
					elsif char[letter] != " _ " and wordChar.include? letter or letter_used.include? letter
						alert("letter already used")
							
					else
						lives -= 1
						letter_used.push(letter)
						letter_used = letter_used.sort
						letter_place.replace letter_used


					restart.click{
						restart_game()
					}
					
					case lives
						when 5
					        $e.show
					    when 4
				        	$f.show
				        when 3
	   						$g.show
				    	when 2
				   			$h.show
				    	when 1
				   			$i.show
				        when 0 

				   			$k.show
				    	end
				    end
					

					if lives == 0
						if confirm("You Lose, The word was #{targetWord}. Play again?")
							restart_game()
						else
							exit
						end
					elsif !char.has_value?(" _ ")
						l = window do
							image "winner2.jpeg"
						end
							timer(3) do
								l.close

							if confirm("You win! Do you want to play again?")
								restart_game()
							else
								exit
							end
						end
					end	
				end
		   	end
		end
	end
	game = new_game()
end