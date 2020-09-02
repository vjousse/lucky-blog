class Users::Index < BrowserAction
  include Auth::AllowGuests

  route do
    plain_text "Render something in Users::Index"
  end
end
