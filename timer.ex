defmodule Timer do
  use GenServer
 
  def init(num) do
		time_info()		
    {:ok, {num, :start}}
  end
  
  def time_left(pid) do
    GenServer.call(pid, :time_left)
  end 	

	def start(pid) do
		GenServer.cast(pid, :start)
	end

	def stop(pid) do
		GenServer.cast(pid, :stop)
	end

	def handle_cast(:start, {num, :stop}) do
		{:noreply, {num, :start}}
	end

	def handle_cast(:stop, {num , :start}) do
		{:noreply, {num, :stop}}
	end

	def handle_call(:time_left, _from, {num, _} = state) do
		{:reply, num, state}
	end

	def handle_info(:time, {0, :start} = state) do
		time_info()
		{:noreply, state}
	end

	def handle_info(:time, {num, :start}) do		
		time_info()
		{:noreply, {num-1, :start}}		
	end

	def handle_info(:time, {_, :stop} = state) do
		time_info()			
		{:noreply, state}		
	end	

	def time_info do
		Process.send_after(self(), :time, 1000)
	end

end


