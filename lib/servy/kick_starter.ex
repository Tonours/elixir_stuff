defmodule Servy.KickStarter do
  use GenServer

  alias Servy.HttpServer

  def start_link(_args) do
    IO.puts("Starting kick starter...")
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Process.flag(:trap_exit, true)
    server_pid = start_server()
    {:ok, server_pid}
  end

  def handle_info({:EXIT, pid, reason}, _state) do
    IO.puts("HttpServer exited: #{inspect(reason)}")
    server_pid = start_server()
    {:noreply, server_pid}
  end

  defp start_server do
    IO.puts("Starting HTTP server...")
    port = Application.get_env(:servy, :port)
    server_pid = spawn_link(HttpServer, :start, [port])
    Process.register(server_pid, :http_server)
    server_pid
  end
end
