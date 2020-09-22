module Lang::Detect
  macro included
    after detect_lang
  end

  private def detect_lang
    if !session.get?(:lang)

      if md = /\/(en|fr).*/.match(request.path)
        if detected_lang = md[1]?
          Log.info { {detected_lang: detected_lang} }
        end
      end
      Log.info { {request: request.path, method: request.method, path: request.path} }
    end
    continue
  end
end
