<?php
$request = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// On retire dynamiquement la BASE_URL du chemin pour que le switch fonctionne
// if (BASE_URL !== '' && strpos($request, BASE_URL) === 0) {
//     $request = substr($request, strlen(BASE_URL));
// }

if ($request === '' || $request === false) { $request = '/'; }

switch ($request) {
    case '/':
        header('Location: /accueil'); 
        break;
    case '/accueil':      $section = 'homepage'; break;
};

