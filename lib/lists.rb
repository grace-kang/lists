require "letter_opener"
Hanami::Mailer.configure do
  delivery do
    development LetterOpener::DeliveryMethod, location: Hanami.root.join('tmp/letter_opener')
  end
end.load!

module Lists
end
