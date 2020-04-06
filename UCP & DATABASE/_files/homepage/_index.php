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

if (isset($_SESSION["username"])) {
    ?>
    Hallo, <?=$myrow['username']?>
    <?php
} else {
    ?>
    <form action="" method="POST">
        <input type="text" class="username owninput" name="username" placeholder="Username" required>
        <input type="password" class="password owninput" name="password" placeholder="Passwort" pattern=".{5,15}" required title="Mindestens 5 und Maximal 15 Zeichen!">
        <button name="register" class="ownbtn">Registrieren</button>
    </form>
    <?php
}
?>