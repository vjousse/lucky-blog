class Content::About < BrowserAction
  include Auth::AllowGuests

  get "/about" do
    html Content::AboutPage
  end

end
