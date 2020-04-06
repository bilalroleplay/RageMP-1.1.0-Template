<?php
error_reporting(0); //Blendet PHP Error aus
session_start(); //Startet eine Session

//Tut die Person abmelden
if (isset($_GET['logout'])) {
    if (isset($_SESSION['username'])) {
        session_unset();
        session_destroy();
    }
}

// Filterung gegen HTML UND JS Tags
function protect($string, $output = false) {
    $string = str_replace("'", "", $string);
    $string = str_replace("alert(", "", $string);
    $string = str_replace("prompt(", "", $string);
    $string = str_replace("/*", "", $string);
    $string = str_replace("document.cookie", "", $string);
    $string = str_replace('document["cookie"]', '', $string);
    $string = str_replace('window["alert"', '', $string);

    $string = strip_tags($string);

    return $string;
}

//XSS Schutz
if (isset($_POST)) {
    foreach ($_POST as $key => $val) {
        $_POST[$key] = $db->escapeString(protect($val));
    }
}

if (isset($_SESSION['username'])) {
    $check = $db->query("SELECT username FROM accounts WHERE username = ? AND password = ?", $_SESSION['username'], $_SESSION['password']);
    if ($check->numRows() > 0) {
        $myrow = $check->fetchArray();
    } else {
        //Konnte der Spieler nicht gefunden werden in der Datenbank wird die Session beendet
        header('Location: /index&logout');
        exit();
    }
} else {
    $myrow['username'] = 'Guest';
    $myrow['rank'] = 0;
}
?>