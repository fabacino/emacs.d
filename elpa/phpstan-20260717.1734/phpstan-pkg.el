;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "phpstan" "20260717.1734"
  "Interface to PHPStan (PHP static analyzer)."
  '((emacs       "27.1")
    (compat      "30")
    (php-mode    "1.22.3")
    (php-runtime "0.2"))
  :url "https://github.com/emacs-php/phpstan.el"
  :commit "00942a5d5b28560bd08f7355d131074772bb7a01"
  :revdesc "00942a5d5b28"
  :keywords '("tools" "php")
  :authors '(("USAMI Kenta" . "tadsan@zonu.me"))
  :maintainers '(("USAMI Kenta" . "tadsan@zonu.me")))
