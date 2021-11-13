defmodule Chess do
  use GenServer

  # Client

  def start_link(time) when is_integer(time) do		
    GenServer.start_link(__MODULE__, {:running, :stopped, time, time})		
  end  

	def push_button(pid, :player1) do		
		GenServer.cast(pid, :push1)			
	end	

	def push_button(pid, :player2) do
		GenServer.cast(pid, :push2)		
	end

  def get_time_left(pid, :player1) do
    GenServer.call(pid, :get_time_left1)
  end

	def get_time_left(pid, :player2) do
    GenServer.call(pid, :get_time_left2)
  end

  # Server (callbacks)

	@impl true
	def init(chess) do						
		schedule_timer(:player1)		
  	{:ok, chess}
  end  

  @impl true
  def handle_cast(:push1, {:running, :stopped, time_left1, time_left2}) do #TIMER1
		schedule_timer(:player2)
    {:noreply, {:stopped, :running, time_left1, time_left2}}
  end	

  @impl true
  def handle_cast(:push2, {:stopped, :running, time_left1, time_left2}) do #TIMER2
		schedule_timer(:player1)
    {:noreply, {:running, :stopped, time_left1, time_left2}}
  end


  @impl true
  def handle_call(:get_time_left1, _from, {timer_state1, timer_state2, time_left1, time_left2}) do #TIMER1
    {:reply, time_left1, {timer_state1, timer_state2, time_left1, time_left2}}
  end

	@impl true
  def handle_call(:get_time_left2, _from, {timer_state1, timer_state2, time_left1, time_left2}) do #TIMER2
    {:reply, time_left2, {timer_state1, timer_state2, time_left1, time_left2}}
  end

	@impl true
  def handle_info(:afterasecond1, {_, _, 0, time_left2}) do	#TIMER1	
		IO.puts("Player2 wins")
    {:noreply, {:stopped, :stopped, 0, time_left2}}		
  end
  def handle_info(:afterasecond1, {:running, :stopped, time_left1, time_left2}) do #TIMER1
				   
		schedule_timer(:player1)
    {:noreply, {:running, :stopped, time_left1 - 1, time_left2}}
  end
  def handle_info(:afterasecond1, {:stopped, timer_state2, time_left1, time_left2}) do #TIMER1	
    {:noreply, {:stopped, timer_state2, time_left1, time_left2}}
  end

	@impl true
  def handle_info(:afterasecond2, {_, _, time_left1, 0}) do	#TIMER2	
		IO.puts("Player1 wins")
    {:noreply, {:stopped, :stopped, time_left1, 0}}
		
  end
  def handle_info(:afterasecond2, {:stopped, :running, time_left1, time_left2}) do #TIMER2
    schedule_timer(:player2)
    {:noreply, {:stopped, :running, time_left1, time_left2 - 1}}
  end
  def handle_info(:afterasecond2, {timer_state1, :stopped, time_left1, time_left2}) do #TIMER2
    {:noreply, {timer_state1, :stopped, time_left1, time_left2}}
  end	

  defp schedule_timer(:player1) do #TIMER1	
    Process.send_after(self(), :afterasecond1, 1000)
  end

	defp schedule_timer(:player2) do #TIMER2
    Process.send_after(self(), :afterasecond2, 1000)
  end

end


