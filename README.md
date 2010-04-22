# textractor

textractor is a ruby library that provides a simple wrapper around CLI
tools for extracting text from PDF and Word documents.

## Setup

    gem install textractor

In order to use textractor you have to install a few command line
tools.

### OS X

    port install wv xpdf links

I recommend using also passing +no_x11 to the install command, but
this may not work on all systems due to dependency issues.

    port install wv xpdf links +no_x11

### Ubuntu 8.04

    apt-get install wv xpdf-utils links

## Usage

Due to textractor's reliance on command line tools all the methods in
textractor work on paths not File objects.

    document = Textractor::Document.new(path_to_document)
    document.text # => "Ruby on rails developer"

There is also a convenience method on Textractor.

    Textractor.text_from_file(path_to_document) # => "Ruby on rails developer"

Textractor will attempt to guess what type of document you're trying
to extract text from.  However, if you know the content type of your
document, you can provide it and Textractor won't guess.

    Textractor.text_from_file(path_to_document, :content_type => "application/doc")

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Michael Guterl. See LICENSE for details.
