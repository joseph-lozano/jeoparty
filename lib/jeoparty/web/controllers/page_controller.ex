defmodule Jeoparty.Web.PageController do
  use Jeoparty.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
