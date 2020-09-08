class Blog::Index < BrowserAction
  include Auth::AllowGuests

  get "/blog" do
    if current_user?
      redirect Me::Show
    else
      # When you're ready change this line to:
      #
      #   redirect SignIns::New
      #
      # Or maybe show signed out users a marketing page:
      #
      #   html Marketing::IndexPage
      html Blog::IndexPage
    end
  end
end
