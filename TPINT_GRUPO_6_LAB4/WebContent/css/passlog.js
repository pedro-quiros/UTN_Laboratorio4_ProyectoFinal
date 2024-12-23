function togglePasswordVisibility() {
    const passwordField = document.getElementById("password");
    const passwordButton = document.querySelector(".toggle-password");

    if (passwordField.type === "password") {
        passwordField.type = "text";
        passwordButton.textContent = "🙈"; // Cambia al ícono de "ocultar"
    } else {
        passwordField.type = "password";
        passwordButton.textContent = "👁️"; // Cambia al ícono de "mostrar"
    }
}