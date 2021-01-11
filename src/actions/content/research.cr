class Content::Research < BrowserAction
  include Auth::AllowGuests

  get "/research" do
    html Content::ResearchPage
  end
end
