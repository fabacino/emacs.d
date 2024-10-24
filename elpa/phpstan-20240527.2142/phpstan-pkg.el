;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "phpstan" "20240527.2142"
  "Interface to PHPStan."
  '((emacs       "24.3")
    (compat      "29")
    (php-mode    "1.22.3")
    (php-runtime "0.2"))
  :url "https://github.com/emacs-php/phpstan.el"
  :commit "6f1c7bb357b1eb90b10a081f1831c1c548c40456"
  :revdesc "6f1c7bb357b1"
  :keywords '("tools" "php")
  :authors '(("USAMI Kenta" . "tadsan@zonu.me"))
  :maintainers '(("USAMI Kenta" . "tadsan@zonu.me")))
