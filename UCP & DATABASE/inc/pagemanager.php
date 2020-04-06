<?php
//Wenn die Seite geladen wird und nur / in der URL steht soll die index geladen werden
if (isset($_GET['page']) == '') {
	$GET[0] = 'index';
} else {
	$GET = explode("/", $_GET['page']);
}

//Fragt ob die erste Zeile in der URL zur ACP oder Homepage gehört
if ($GET[0] === 'acp') {
    if ($GET[1] === '') {
        $pagename = $GET[1] = 'index';
    } else {
        $pagename = $GET[1];
    }
    $folder = 'acp';
} else {
    $pagename = $GET[0];
    $folder = 'homepage';
}

$check_page = $db->query("SELECT * FROM cms_pages WHERE name = ? AND content = ?", $pagename, $folder);
if ($check_page->numRows() > 0) {
    $page = $check_page->fetchArray();

    if (!file_exists('./_files/' . $page['content'] . '/_' . $page['name'] . '.php')) { //Existiert keine Datei mit diesem Namen wird man zur 404 weitergeleitet
        $pagename = '404';
		$folder = 'homepage';
		$page['header'] = '1';
        $page['title'] = 'Fehler';
    }

    /*if ($myrow['rank'] < $page['min_rank']) { //Ist der Rank niedriger als wie in der Datenbank vorgegeben wird man zur 404 weitergeleitet
        header('Location: /404&error=notauthorized');
        exit();
    }*/
    
} else { //Existiert die Seite nicht in der Datenbank wird man zur 404 weitergeleitet
	$pagename = '404';
	$folder = 'homepage';
    $page['header'] = '1';
    $page['title'] = 'Fehler';
}

if ($page['header'] === '1') {
    include('./inc/template/homepage/header.php'); //Included den Header
    include('./_files/' . $folder . '/_' . $pagename . '.php'); //Included den Seiteninhalt
    include('./inc/template/homepage/footer.php'); //Included den Footer
} else {
    include('./_files/' . $folder . '/_' . $pagename . '.php'); //Included den Seiteninhalt
}
?>