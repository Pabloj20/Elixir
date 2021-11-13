defmodule PalindromicNumber do
	require Integer
	def list_palindromic() do
		list=[]
		palindromic(list,0)
	end

	def palindromic(list,num) do		
		map = %{palindromic: 0, list_cube: [], list_square: [], coef: 0}
		pnum = palindromic_generator(map, num + 1)
		list = list ++ [pnum]
		if length(list) == 5 do
			Enum.reduce(list, fn x, acc -> x + acc end)
		else
			palindromic(list, pnum)
		end		
	end

	def palindromic_generator(map, num) do
		if is_palindromic?(Integer.digits(num))	do			
			other_combination(map, num, 1)																				
		else
			palindromic_generator(map, num+1)
		end			
	end

	def is_palindromic?(list) when length(list) == 0 or length(list) == 1, do: true
	def is_palindromic?(list) do		
		[first_digit] = Enum.take(list,1) 
		[last_digit] = Enum.take(list,-1)
		if first_digit==last_digit do		
			list
			|> Enum.drop(1)
			|> Enum.drop(-1)
			|> is_palindromic?
		else
			false
		end
	end	

	def other_combination(map, num, coef_cube) do #any combination		
		if :math.pow(coef_cube, 3) >= num do	
			map_reset = %{palindromic: 0, list_cube: [], list_square: [], coef: 0}
			palindromic_generator(map_reset, num+1)
		else
			coef_square = :math.sqrt(num - :math.pow(coef_cube,3))
			if coef_square == coef_cube do
				other_combination(map, num, coef_cube+1)
			else
				{_, i}= Float.ratio(coef_square)					
				if i == 1 do																											
						map_result = %{map | palindromic: num, list_cube: map.list_cube ++ [coef_cube], list_square: map.list_square ++ [coef_square], coef: coef_cube}
						if length(map_result.list_cube) == 4 do								
							map_result.palindromic
						else															
							other_combination(map_result, map_result.palindromic, map_result.coef + 1)	
						end					
				else
					other_combination(map, num, coef_cube+1)
				end
			end
		end		
	end		
end