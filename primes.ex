defmodule Primes do 

  def primes(1), do: [2]
  def primes(2), do: [2,3]
  def primes(primes_num) do 
    x=3  
    list=[2,3]     
    process(x,primes_num,list)
  end

  def process(x,primes_num,list) do               
    x = generator(x)
       
    if is_prime?(x) do
      list = list ++ [x]            
      if length(list) == primes_num do
        list
      else
        process(x,primes_num,list)
      end
    else
      process(x,primes_num,list)
    end
  end

  def generator(x), do: x+2

  def is_prime?(x) do        
    rem_num(x,x-1)
  end

  def rem_num(x,3) do
    if rem(x,3) == 0 do
      false
    else
      true
    end
  end
  def rem_num(x,num) do 
    if rem(x,num) == 0 do
      false
    else            
      rem_num(x,num-1)
    end
  end
end

