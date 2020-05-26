<?php
if (isset($_POST['register'])) {

    $username = $_POST['username'];
    $password = $_POST['password'];

    $db->query("INSERT INTO accounts SET username = ?, password = ?", $username, $password)->affectedRows();
    $_SESSION['username'] = $username;
    $_SESSION['password'] = $password;
    header("Location: /index&register=success");
    exit();
}

if (isset($_POST['login'])) {

    $username = $_POST['username'];
    $password = $_POST['password'];

    $query = $db->query("SELECT username, password FROM accounts WHERE username = ? AND password = ?", $username, $password);
    if ($row = $query->fetchArray()) {
        if ($row['password'] == $password) {
            $_SESSION['username'] = $username;
            $_SESSION['password'] = $password;
            header("Location: /index&login=success");
            exit();
        } else {
            header("Location: /index&login=wrongpassword");
            exit();
        }
    } else {
        header("Location: /index&login=wronguser");
        exit();
    }

}

if (isset($_SESSION["username"])) {
    ?>
    <div class="login-form">
        <p>Hallo, <?=$myrow['username']?></p>
    </div>
    <div class="home-content">
        <p>Maximal: <?=$myrow['max_characters']?>, Chars</p>
        <p>Vorhandene Chars: <?=$db->query("SELECT id FROM characters WHERE account_id = ?", $myrow["id"])->numRows();?></p>
        <?php 
            $charcount = $db->query("SELECT id FROM characters WHERE account_id = ?", $myrow["id"])->numRows();
            if ($charcount < $myrow['max_characters']) {
                ?>
                <a href="/create"><h3>Character erstellen</h3></a>
                <?php
            }
        ?>
    </div>
    <?php
} else {
    ?>
    <div class="login-form">
    <form action="" method="POST">
        <div class="form-row">
        <div class="col">
            <input type="text" name="username" class="form-control" placeholder="Username" required>
        </div>
        <div class="col">
            <input type="password" name="password" class="form-control" placeholder="Passwort" pattern=".{5,15}" required title="Mindestens 5 und Maximal 15 Zeichen!">
        </div>
        <div class="col">
            <button name="login" class="btn btn-success" style="width: 100%;">Einloggen</button>
        </div>
        <div class="col">
            <button name="register" class="btn btn-success" style="width: 100%;">Registrieren</button>
        </div>
    </div>
    </form>
    </div>
    <?php
}
?>