$('#loginButton').click(() => {
    $('.alert').remove();
   
    var username = $('#loginUsernameText').val();
    var password = $('#loginPasswordText').val();

    mp.trigger('uiLogin_LoginButton', username, password);
});