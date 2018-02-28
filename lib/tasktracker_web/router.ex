defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(TasktrackerWebAdd)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TasktrackerWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/feed", PageController, :feed)
    get("/report", PageController, :report)
    get("/timeblock", PageController, :timeblock)
    # get("/profile", PageController, :profile)
    resources("/users", UserController)
    resources("/tasks", TaskController)

    post("/session", SessionController, :create)
    delete("/session", SessionController, :delete)
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TasktrackerWeb do
    pipe_through(:api)
    resources("/manages", ManageController, except: [:new, :edit])
    resources("/timeblocks", TimeblockController, except: [:new, :edit])
  end
end
