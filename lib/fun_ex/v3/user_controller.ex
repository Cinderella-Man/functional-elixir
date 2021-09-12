defmodule FunEx.V3.UserController do
  # use FunEx, :controller

  def allowed?(conn, %{"email" => email}) do
    result = FunEx.V3.UserService.allowed?(email, &File.read/1)
    # render(conn, "temp.html", allowed: result)
  end
end
