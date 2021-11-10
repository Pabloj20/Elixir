defmodule RomanNumber do

  def units_n(0), do: ""
  def units_n(1), do: "I"
  def units_n(2), do: "II"
  def units_n(3), do: "III"
  def units_n(4), do: "IV"
  def units_n(5), do: "V"
  def units_n(6), do: "VI"
  def units_n(7), do: "VII"
  def units_n(8), do: "VIII"
  def units_n(9), do: "IX"

  def dozens_n(0), do: ""
  def dozens_n(1), do: "X"
  def dozens_n(2), do: "XX"
  def dozens_n(3), do: "XXX"
  def dozens_n(4), do: "XL"
  def dozens_n(5), do: "L"
  def dozens_n(6), do: "LX"
  def dozens_n(7), do: "LXX"
  def dozens_n(8), do: "LXXX"
  def dozens_n(9), do: "XC"

  def hundreds_n(0), do: ""
  def hundreds_n(1), do: "C"
  def hundreds_n(2), do: "CC"
  def hundreds_n(3), do: "CCC"
  def hundreds_n(4), do: "CD"
  def hundreds_n(5), do: "D"
  def hundreds_n(6), do: "DC"
  def hundreds_n(7), do: "DCC"
  def hundreds_n(8), do: "DCCC"
  def hundreds_n(9), do: "CM"

  def thousands_n(0), do: ""
  def thousands_n(1), do: "M"
  def thousands_n(2), do: "MM"
  def thousands_n(3), do: "MMM"

  def digits_list(list) do
    list 
    |> Enum.reverse
    |> Enum.zip([&units_n/1, &dozens_n/1, &hundreds_n/1, &thousands_n/1])    
    |> Enum.map(&num_introduce/1)
    |> Enum.reverse
    |> Enum.join("")
  end

  def num_introduce({num, fun}) do
      fun.(num)
  end

  def roman_number(n) when n>=4000, do: "I can´t convert"
  def roman_number(n) do
    n
    |> Integer.digits
    |> digits_list
  end

end