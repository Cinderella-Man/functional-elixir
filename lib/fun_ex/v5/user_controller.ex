defmodule FunEx.V5.UserController do
  # use FunEx, :controller

  def allowed?(conn, %{"email" => email}) do
    result = FunEx.V5.UserService.allowed?(email)
    # render(conn, "temp.html", allowed: result)
  end
end
