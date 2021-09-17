defmodule FunEx.V7.UserController do
  # use FunEx, :controller

  def allowed?(conn, %{"email" => email}) do
    result = FunEx.V7.UserService.allowed?(email)
    # render(conn, "temp.html", allowed: result)
  end
end
