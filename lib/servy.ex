defmodule Servy do
  use Application

  def start(_type, _args) do
    IO.puts("Starting Servy...")
    Servy.Supervisor.start_link()
  end
end
