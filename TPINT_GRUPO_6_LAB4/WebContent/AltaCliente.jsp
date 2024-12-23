<%@page import="Entidades.Provincia"%>
<%@page import="negocioImpl.ClienteNegocioImpl"%>
<%@page import="negocio.ClienteNegocio"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="Entidades.Nacionalidades"%>
<%@page import="Entidades.Localidad"%>
<%@page import="Entidades.Provincia"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        	<link rel="stylesheet" type="text/css" href="css/Navbar.css">
	        <link rel="stylesheet" type="text/css" href="css/altclien.css">		               
    <style>
        .mensaje-cuadro {
            background-color: #f5f5f5; 
            color: #721c24; 
            border: 1px solid #f5c6cb; 
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            font-size: 16px;
        }
		    .mensaje-error {
		    color: red;
		    font-weight: bold;
		}
		
			.mensaje-exito {
		    color: green;
		    font-weight: bold;
		}
    </style>
    
</head>
<body>
<div class="encabezado">
    <h1>Alta Cliente</h1>
</div>
	<div class="mensaje-cuadro">
	    <% 
	        String mensaje = (String) request.getAttribute("mensaje");
	        String mensajeError = (String) request.getAttribute("mensajeError");
	    %>
	    <% if (mensaje != null) { %>
	        <div class="mensaje mensaje-exito">
	            <%= mensaje %>
	        </div>
	    <% } %>
	    <% if (mensajeError != null) { %>
	        <div class="mensaje mensaje-error">
	            <%= mensajeError %>
	        </div>
	    <% } %>
	</div>

  <div class="form-register">   
        <!-- Formulario para registrar cliente -->
        <form method="POST" action="ServletBanco" onsubmit="validaYConfirma(this)" >
        <input type="hidden" name="action" value="loadProvinces">       
         <p>
    <label class="form-label" for="nacionalidad">Nacionalidad</label>
    <select class="controls" id="nacionalidad" required name="txtNacionalidad" onchange="this.form.submit()">
 <option value="" <%= (request.getAttribute("limpiarFormulario") != null || "".equals(request.getParameter("txtNacionalidad"))) ? "selected" : "" %>>Seleccione</option>
        <option value="1" <%= "1".equals(request.getParameter("txtNacionalidad")) ? "selected" : "" %>>Argentina (+54 11)</option>
        <option value="2" <%= "2".equals(request.getParameter("txtNacionalidad")) ? "selected" : "" %>>Brasil(+55)</option>
        <option value="3" <%= "3".equals(request.getParameter("txtNacionalidad")) ? "selected" : "" %>>Chile(+56)</option>
        <option value="4" <%= "4".equals(request.getParameter("txtNacionalidad")) ? "selected" : "" %>>Uruguay(+598)</option>
        <option value="5" <%= "5".equals(request.getParameter("txtNacionalidad")) ? "selected" : "" %>>Paraguay(+595)</option>
    </select>
</p>

   <p>
    <label class="form-label" for="provincia">Provincia</label>
    <select class="controls" id="provincia" name="txtProvincia" required onchange="this.form.submit()">
        <option value="">Seleccione</option>
        <%
            if (request.getAttribute("provincias") != null) {
                ArrayList<Provincia> provincias = (ArrayList<Provincia>) request.getAttribute("provincias");
                String provinciaSeleccionada = request.getParameter("txtProvincia"); // Obtener el valor de la provincia seleccionada

                for (Provincia provincia : provincias) {
        %>
        <option value="<%= provincia.getId() %>" <%= provinciaSeleccionada != null && provinciaSeleccionada.equals(String.valueOf(provincia.getId())) ? "selected" : "" %>>
    <%= provincia.getProvincia() %>
</option>
        <% 
                }
            }
        %>
    </select>
</p>
<p>
    <label class="form-label" for="localidad">Localidad</label>
    <select class="controls" id="localidad" name="txtLocalidad" required required onchange="this.form.submit()">
        <option value="">Seleccione</option>
        <%
            if (request.getAttribute("localidades") != null) {
                ArrayList<Localidad> localidades = (ArrayList<Localidad>) request.getAttribute("localidades");
                String localidadSeleccionada = request.getParameter("txtLocalidad"); // Obtener el valor de la localidad seleccionada

                for (Localidad localidad : localidades) {
        %>
        <option value="<%= localidad.getIdLocalidad() %>" <%= localidadSeleccionada != null && localidadSeleccionada.equals(String.valueOf(localidad.getIdLocalidad())) ? "selected" : "" %>>
            <%= localidad.getLocalidad() %>
        </option>
        <% 
                }
            }
        %>
    </select>
  
</p>
                <p>
                    <label class="form-label" for="nombre">Nombre</label>
                    <input class="controls" id="nombre" type="text" placeholder="Ingrese el nombre" required name="txtNombre" onkeypress="validarSoloLetras(event)">                   
                </p>
                <p>
                    <label class="form-label" for="apellido">Apellido</label>
                    <input class="controls" id="apellido" type="text" placeholder="Ingrese el apellido" required name="txtApellido" onkeypress="validarSoloLetras(event)">
                </p>
                <p>
                    <label class="form-label" for="dni">DNI</label>
                    <input class="controls" id="dni" type="number" maxlength="8" placeholder="Ingrese el DNI" required name="txtDNI" onkeypress="validarSoloNumeros(event)" oninput="validarLongitudDni(this)">
                </p>
                <p>
                    <label class="form-label" for="cuil">CUIL</label>
                    <input class="controls" id="cuil" maxlength="11" type="number" placeholder="Ingrese el CUIL" required name="txtCUIL" onkeypress="validarSoloNumeros(event)" oninput="validarLongitudCuil(this)">
                </p>
                <p>
                    <label class="form-label" for="sexo">Sexo</label>
                    <select class="controls" id="sexo" required name="txtSexo">
                        <option value="">Seleccione</option>
                        <option value="Masculino">Masculino</option>
                        <option value="Femenino">Femenino</option>
                        <option value="Otro">Otro</option>
                    </select>
                </p>
   				<p>
			    <p>
				    <label class="form-label" for="fechaNacimiento">Fecha de Nacimiento</label>
				    <input 
					    class="controls" 
					    id="fechaNacimiento" 
					    type="text" 
					    maxlength="10" 
					    placeholder="YYYY-MM-DD" 
					    pattern="\d{4}-\d{2}-\d{2}" 
					    oninput="validateDateInput(this)" 
					    required name="txtFechaNacimiento" />
				</p>

                <p>
                    <label class="form-label" for="direccion">Direcci�n</label>
                    <input class="controls" id="direccion" type="text" placeholder="Ingrese la direcci�n" required name="txtDireccion">
                </p>
                <p>
                    <label class="form-label" for="email">Correo Electr�nico</label>
                    <input class="controls" id="email" type="email" placeholder="Ingrese el correo electr�nico" required name="txtEmail">
                </p>
                <p>
                    <label class="form-label" for="telefono">Tel�fono</label>
                    <input class="controls" id="telefono" type="text" maxlength="8" placeholder="Ingrese el tel�fono" required name="txtTelefono" onkeypress="validarSoloNumeros(event)">
                </p>
                <p>
                    <label class="form-label" for="usuario">Usuario</label>
                    <input class="controls" id="usuario" type="text" placeholder="Ingrese el nombre de usuario" required name="txtUsuario">
                </p>
                <p>
                    <label class="form-label" for="contrasena">Contrase�a</label>
                    <input class="controls" id="contrasena" type="password" placeholder="Ingrese la contrase�a" required name="txtContrasena1">
                </p>
                <p>
                    <label class="form-label" for="contrasena2">Confirmar Contrase�a</label>
                    <input class="controls" id="contrasena2" type="password" placeholder="Confirme la contrase�a" required name="txtContrasena2">
                </p>
                 <input type="hidden" name="action" value="ValidarContrase�as">
				<p>
				    <label class="form-label" for="TipoUsuario">Tipo Usuario</label>
				    <select class="controls" id="TipoUsu" required name="txtTipoUsuario">
				        <option value="">Seleccione</option>
				        <option value="1">Admin</option>
				        <option value="0">Cliente</option>
				    </select>
				</p>
                <input type="hidden" name="action" value="ValidarContrase�as">
          </fieldset>
            
            <div class="botones-container">
                <input class="botons" id="btnAceptar" type="submit" value="Aceptar" required name="btnAltaCliente">
            </div>         
        </form>
    </div>

<script>
function confirmarAlta(form) 
{
    const confirmacion = confirm("�Est�s seguro de dar Alta este cliente?");
    if (confirmacion) {
        return true;
    } else {
        console.log("Alta cancelada.");
        return false;
    }
}
function validarSoloLetras(event) {
    const key = event.key;
    const regex = /^[a-zA-Z]+$/;

    if (!regex.test(key) && key !== "Backspace") {
        event.preventDefault(); // Evita que se ingrese el car�cter no permitido
        alert("Solo se permiten letras.");
    }
}

function validarSoloNumeros(event) {
    const key = event.key;
    const regex = /^[0-9]$/;

    if (!regex.test(key) && key !== "Backspace" && key !== "Tab" && key !== "Delete" && key !== "ArrowLeft" && key !== "ArrowRight") {
        event.preventDefault(); // Evita que se ingrese un car�cter no permitido
        alert("Solo se permiten n�meros.");
    }
}

function validarLongitudDni(input) {
	const longitudExacta   = 8;
	 
    if (input.value.length > longitudExacta) {
        alert("El DNI no puede tener m�s de 8 d�gitos.");
        input.value = input.value.slice(0, longitudExacta); // Recorta el valor a 11 caracteres
        return;
    }   
}

function validarLongitudCuil(input) {
    const longitudExacta   = 11;
 
    if (input.value.length > longitudExacta) {
        alert("El CUIL no puede tener m�s de 11 d�gitos.");
        input.value = input.value.slice(0, longitudExacta); // Recorta el valor a 11 caracteres
        return;
    }   
}

function validateDateInput(input) {    
    input.value = input.value.replace(/[^0-9-]/g, '').slice(0, 10);   
    const pattern = /^\d{4}-\d{2}-\d{2}$/; // Formato DD-MM-YYYY
    if (input.value && !pattern.test(input.value)) {
        input.setCustomValidity("Por favor, ingrese la fecha en el formato YYYY-MM-DD.");
    } else {
        input.setCustomValidity(""); 
  }
}

function validaYConfirma(form){
	if(!confirmarAlta(form)){
		return false;
	}
	return true;
}

</script>  
</body>
</html>