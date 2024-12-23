<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeBank - Sistema Bancario</title>
    <link rel="stylesheet" href="css/Navbar.css">
</head>
<body>
    <!-- Navbar -->
    <div class="navegador">
        <div class="nav-brand-container">
            <a class="nav-brand">CodeBank</a>
            
            <% 
                String nombreCliente = (String) session.getAttribute("nombreCliente");
                Integer tipoUsuario = (Integer) session.getAttribute("tipoUsuario");                 
                if (nombreCliente != null) {
            %>
              
            <% if (tipoUsuario != null && tipoUsuario == 0) { %>
            <a class="logoNav" href="Cliente.jsp" title="Ir a la p�gina de inicio">
                <img src="img/icoHome.png" alt="�cono de la p�gina de inicio" />
            </a>
            <a href="InformacionPersonal.jsp" title="Ir a mi perfil">
                <img src="img/icoInfo.png" alt="�cono de informaci�n" />
            </a>
            <% } %>
            
            <% if (tipoUsuario != null && tipoUsuario == 1) { %>
                <!-- Mostrar la opci�n de Administrador solo si el usuario es administrador -->
                <a href="Administrador.jsp" title="Ir a secci�n de Administrador">
                    <img src="img/icoAdmin.png" alt="�cono de Administraci�n" />
                </a>
            <% } %>
            
            <div class="nav-welcome">
                <span class="welcome-message">�Bienvenido, <%= nombreCliente %>!</span>
            </div>
            
         
            <a href="Logout.jsp" class="logout" title="Cerrar sesi�n">
                <img src="img/icoLogout.png" alt="�cono de logout" />
            </a>

            <% 
                } else { 
            %>
                <!-- Navbar si el usuario no est� logueado -->
                <div class="nav-welcome">
                    <span class="welcome-message">�Bienvenido!</span>
                </div>
            <% 
                }
            %>
        </div>

        <span class="time" id="time"></span>
    </div>

    <script src="js/scripts.js"></script>
</body>
</html>
