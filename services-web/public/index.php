<?php
require_once '../config/config.php';

// Détecte automatiquement la racine du site
// $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? "https://" : "http://";
// $domain = $_SERVER['HTTP_HOST'];
// define('BASE_URL', 'https://' . $domain);

require_once CORE_PATH . '/Router.php';

// Variables SEO 
switch ($section) {
    case 'homepage':
        $pageTitle = 'Gestock - Accueil';
        $pageDescription = 'La page d\'accueil de Gestock, application de gestion de stock pour des petites entreprises.';
    default:
        $pageTitle = 'Gestock';
        $pageDescription = 'Gestock, application de gestion de stocks';
}

if (!isset($section)) {
    $section = 'homepage';
}

ob_start();

switch ($section){
    case 'homepage':
        require_once CONTROLLER_PATH . '/homepageController.php';
        break;
    default : 
        require_once CONTROLLER_PATH . '/homepageController.php';
        break;
}
$content = ob_get_clean();

require '../app/views/partials/layout.php';

?>