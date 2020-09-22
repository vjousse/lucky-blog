class Content::ResearchPage < GuestLayout
  def content

    article class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed text-xl" do

      header class: "flex flex-col" do

        h1 "Named Speaker Identification", class: "text-5xl font-serif font-bold pt-20 pb-16"

        para class: "lead" do
          text "Named speaker identification tries to answer a very simple question: "
          strong "who spoke when"
          text "?"
        end
        para class: "lead" do
          text "Such a simple question for more than 3 years of work. You'll find below all my papers (french and english) on the subject and the final version of my "
          a "PhD thesis (in french)", href: "https://github.com/vjousse/phd-thesis"
          text "."
        end
        h2 "Abstract"
        para "The automatic processing of speech is an area that encompasses a large number of works: speaker recognition, named entities detection or transcription of the audio signal into words. Automatic speech processing techniques can extract number of information from audio documents (meetings, shows, etc..) such as transcription, some annotations (the type of show, the places listed, etc..) or even information concerning speakers (speaker change, gender of speaker). All this information can be exploited by automatic indexing techniques that will allow indexing of large document collections."
        para do
          text "The work presented in this thesis are about the "
          strong "automatic indexing of speakers in french audio documents"
          text ". Especially we try to identify the various contributions of the speakers and nominate them by their first and last name. This process is known as named identification of the speaker. The particularity of this work lies in the joint use of audio and its transcript to name the speakers of a document. The first and last name of each speaker is extracted from the document itself (from its rich transcription to be precised), before being assigned to one of the speakers of the document."
        end
        para do
          text "We start by describing the context and previous work on the speaker named identification process before submitting "
          em "Milesin"
          text ", the system developed during this thesis. The contribution of this work lies firstly in "
          strong do
            text "the use of an automatic detector of named entities ("
            a "LIA_NE", href: "http://pageperso.lif.univ-mrs.fr/~frederic.bechet/download.html"
            text ")"
          end
          text " to extract the first name / last name of the transcript. Afterwards, they rely on "
          strong "the theory of belief functions to perform the assignment to the speakers"
          text " of the document and thus take into account the various conflicts that may arise. Finally, an "
          strong "optimal assignment algorithm"
          text " is proposed."
        end
        para do
          text "This system gives an error rate between 12% and 20% on reference transcripts (done manually) based on the corpus used. We then present the advances and limitations highlighted by this work. We propose an initial study of the impact of the use of fully automatic transcriptions on "
          em "Milesin"
          text "."
        end
        a id: "biblio", name: "biblio"
        h2 "Bibliography - 10 articles"
        ul class: "list-group" do
          li class: "list-group-item" do
            strong "Jousse V", class: "green"
            text ". "
            strong do
              em "Identification nommée du locuteur : exploitation conjointe du signal sonore et de sa transcription"
            end
            text ". PhD thesis. 4th of May 2011. "
            a "Source code available on github", href: "https://github.com/vjousse/phd-thesis"
            text ". "
            a "Download as PDF", href: "../../resources/pdf/jousse-phd-thesis.pdf"
          end
          li class: "list-group-item" do
            text "Estève Y, Deléglise P, Meignier S, Petitrenaud S, Schwenk H, Barrault L, Bougares F, Dufour R, "
            strong "Jousse V", class: "green"
            text ", Laurent A, Rousseau A . "
            strong do
              em "Some recent research work at LIUM based on the use of CMU Sphinx."
            end
            text " CMU SPUD Workshop, Dallas(Texas), march 13, 2010. Short article, 6 pages. "
            a "Download as PDF", href: "../../resources/pdf/some-recent-research-work.pdf"
          end
          li class: "list-group-item" do
            text "Petitrenaud S, "
            strong "Jousse V", class: "green"
            text ", Meignier S, Estève Y . "
            strong do
              em "Speaker identification using belief functions."
            end
            text " Information Processing and Management of Uncertainty (IPMU'10), Dortmund(Germany), 28 june- 2 july 2010. Short article, Part I, pp. 179-188. "
            a "Download as PDF", href: "../../resources/pdf/speakerbeliefIPMU10.pdf"
          end
          li class: "list-group-item" do
            text "Petitrenaud S, "
            strong "Jousse V", class: "green"
            text ", Meignier S, Estève Y . "
            strong do
              em "Reconnaissance Automatique de Locuteurs à l'aide de Fonctions de Croyance."
            end
            text " 17e congrès francophone Reconnaissance des Formes et Intelligence Artificielle (RFIA'10), Caen(France), 20-22 janvier 2010. Short article, 7 pages. "
            a "Download as PDF", href: "../../resources/pdf/ident_locuteur_RFIA10.pdf"
          end
          li class: "list-group-item" do
            text "Dufour R, "
            strong "Jousse V", class: "green"
            text ", Estève Y, Béchet F, Linarès G . "
            strong do
              em "Spontaneous Speech Characterization and Detection in Large Audio Database."
            end
            text " 13-th International Conference on Speech and Computer (SPECOM 2009), St Petersburg(Russia), 21-25 june 2009. Short article, 6 pages. "
            a "Download as PDF", href: "../../resources/pdf/EPAC_WP3_2008_01.pdf"
          end
          li class: "list-group-item" do
            strong "Jousse V", class: "green"
            text ", Petitrenaud S, Meignier S, Estève Y, Jacquin C . "
            strong do
              em "Automatic named identification of speakers using diarization and ASR systems."
            end
            text " ICASSP 2009, Taïpei(Taïwan), 19-24 april 2009. Short article, pp. 4557 - 4560. "
            a "Download as PDF", href: "../../resources/pdf/automatic-named-identification.pdf"
          end
          li class: "list-group-item" do
            strong "Jousse V", class: "green"
            text ", Meignier S, Jacquin C, Petitrenaud S, Estève Y, Daille B . "
            strong do
              em "Analyse conjointe du signal sonore et de sa transcription pour l'identification nommée de locuteur."
            end
            text " In Traitement automatique des langues, 50(1), edited by ATALA: Association pour le Traitement Automatique des Langues, 2009. Long article, pp. 201-225. "
            a "Download as PDF", href: "../../resources/pdf/TAL-2009-50-1-08-Jousse.pdf"
          end
          li class: "list-group-item" do
            strong "Jousse V", class: "green"
            text ", Estève Y, Béchet F, Bazillon T, Linarès G . "
            strong do
              em "Caractérisation et détection de parole spontanée dans de larges collections de documents audio."
            end
            text " JEP/TALN 2008, Avignon(France), 9-13 juin 2008. Short article, 4 pages. "
            a "Download as PDF", href: "../../resources/pdf/JOU08-sponta.pdf"
          end
          li class: "list-group-item" do
            strong "Jousse V", class: "green"
            text ", Jacquin C, Meignier S, Estève Y, Daille B . "
            strong do
              em "Etude pour l'amélioration d'un système d'identification nommée du locuteur."
            end
            text " JEP/TALN 2008, Avignon(France), 9-13 juin 2008. Short article, 4 pages. "
            a "Download as PDF", href: "../../resources/pdf/JOU08-spkid.pdf"
          end
          li class: "list-group-item" do
            text "Bazillon T, "
            strong "Jousse V", class: "green"
            text ", Béchet F, Estève Y, Linarès G, Luzzati D . "
            strong do
              em "La parole spontanée : transcription et traitement."
            end
            text " In Traitement Automatique des Langues, 49(3), edited by ATALA: Association pour le Traitement Automatique des Langues, 200. Article long, pp. 47-76. "
            a "Download as PDF", href: "../../resources/pdf/Baz_TAL08.pdf"
          end
        end

      end

    end
  end
end

