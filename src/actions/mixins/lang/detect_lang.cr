module Lang::Detect
  macro included
    after detect_lang
  end

  private def detect_lang
    # Only try to detect the lang if it's not already set in session
    if !session.get?(:lang)
      if md = /\/(en|fr).*/.match(request.path)
        if detected_lang = md[1]?
          Log.info { {detected_lang: detected_lang} }

          session.set(:lang, detected_lang)
        end
      end
    end

    Log.debug { {current_lang: session.get?(:lang)} }
    continue
  end
end
