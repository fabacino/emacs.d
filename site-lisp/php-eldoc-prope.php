<?php

/**
 * Enhanced version of `prope.php` inside php-eldoc package.
 */

$definedFuncs = get_defined_functions();

$funcNames = array_merge(
    $definedFuncs['internal'],
    $definedFuncs['user']
);
sort($funcNames);

$functions = [];

foreach ($funcNames as $funcName) {
    $f = new ReflectionFunction($funcName);

    $params = [];

    foreach ($f->getParameters() as $p) {
        $param = '$' . $p->getName();

        if ($p->isPassedByReference()) {
            $param = '&' . $param;
        }

        if ($p->hasType()) {
            $param = ltrim($p->getType() . " {$param}");
        }

        if ($p->isOptional()) {
            $param = "[{$param}]";
        }

        $params[] = '"' . $param . '"';
    }

    $functions[] = trim('"' . $funcName . '" ' . trim(implode(' ', $params)));
}

echo <<<'ELISP'
(setq php-eldoc-functions-hash
  (let ((hash (make-hash-table :size 2500 :test 'equal)))
    (mapc (lambda (func)
            (puthash (car func) (rest func) hash))
          '(

ELISP;

foreach ($functions as $func) {
    $entry = str_replace('\\', '\\\\', $func);

    echo <<<ELISP
            ({$entry})

ELISP;
}

echo <<<'ELISP'
            ))
    hash))

ELISP;
