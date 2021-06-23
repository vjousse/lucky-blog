class Home::Index < BrowserAction
  include Auth::AllowGuests

  get "/" do
    redirect Blog::Index
  end
end
