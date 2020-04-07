<?php
if (isset($_POST['create'])) {
    $firstname = $_POST['vorname'];
    $lastname = $_POST['nachname'];

    $db->query("INSERT INTO characters SET account_id = ?, first_name = ?, last_name = ?, cash = ?, dim = ?, last_pos_x = ?, last_pos_y = ?, last_pos_z = ?", $myrow['id'], $firstname, $lastname, 8500, 0, -1167.994, -700.4285, 21.89281)->affectedRows();
    header("Location: /index&char=created");
    exit();
}

if (isset($_SESSION["username"])) {
    $max_chars = $db->query("SELECT id FROM characters WHERE account_id = ?", $myrow["id"])->numRows();
    if ($max_chars < $myrow["max_characters"]) {
        ?>
        <div class="login-form">
            <p>Hallo, <?=$myrow['username']?></p>
        </div>
        <div class="home-content">
            <form action="" method="POST">
                <div class="form-row">
                <div class="col">
                    <input type="text" name="vorname" class="form-control" placeholder="Vorname" required>
                    <input type="text" name="nachname" class="form-control" placeholder="Nachname" required>
                    <button name="create" class="btn btn-success" style="width: 100%;">Erstellen</button>
                </div>
            </div>
            </form>
        </div>
        <?php
    } else {
        header('Location: index');
        exit();
    }
}
?>