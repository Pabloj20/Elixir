defmodule EvenNums do
	require Integer
	def fib_generator({prev, next}) do
		if next < 4_000_000 do			
			if Integer.is_even(next) do
				next + fib_generator({next, prev+next})
			else
				fib_generator({next, prev+next})
			end				
		else
			0
		end
	end

	def even_sum do
		fib_generator({1,2})
	end

end
