class Lang::Change < BrowserAction
  include Auth::AllowGuests

  get "/change_lang/:lang" do

    session.set(:lang, lang)

    Log.debug { Post::Lang }

    redirect_back fallback: Home::Index
  end
end
