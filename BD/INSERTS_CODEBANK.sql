USE tpint_grupo_6_lab4;
-- Tabla cliente
INSERT INTO tpint_grupo_6_lab4.cliente (Id, DNI, CUIL, Nombre, Apellido, Sexo, Nacionalidad, FechaNacimiento, Direccion, Localidad, Provincia, CorreoElectronico, Telefono, Activo) VALUES
(1, 12345678, 201234567812, 'Juan', 'Perez', 'Masculino', 'Argentina', '1985-06-15', 'Calle Falsa 123', 'Tigre', 'Buenos Aires', 'juan.perez@example.com', 011123456, 1),
(2, 23456789, 202345678912, 'Maria', 'Gomez', 'Femenino', 'Argentina', '1990-12-01', 'Avenida Siempre Viva 742', 'Rosario', 'Santa Fe', 'maria.gomez@example.com', 034112345, 1),
(3, 34567890, 203456789012, 'Carlos', 'Administrador', 'Masculino', 'Argentina', '1978-03-22', 'Paseo Colon 123', 'Cordoba', 'Cordoba', 'carlos.lopez@example.com', 035112345, 1),
(4, 45678901, 204567890112, 'Ana', 'Martinez', 'Femenino', 'Argentina', '1983-08-13', 'Belgrano 456', 'La Plata', 'Buenos Aires', 'ana.martinez@example.com', 022112345, 1),
(5, 56789012, 205678901212, 'Luis', 'Rodriguez', 'Masculino', 'Argentina', '1975-11-30', 'San Martin 789', 'Mendoza', 'Mendoza', 'luis.rodriguez@example.com', 026112367, 1),
(6, 67890123, 206789012312, 'Laura', 'Fernandez', 'Femenino', 'Argentina', '1989-04-07', 'Sarmiento 123', 'Tucuman', 'Tucuman', 'laura.fernandez@example.com', 038112567, 1),
(7, 78901234, 207890123412, 'Jorge', 'Garcia', 'Masculino', 'Argentina', '1982-02-20', 'Rivadavia 456', 'Posadas', 'Misiones', 'jorge.garcia@example.com', 037612345, 1),
(8, 89012345, 208901234512, 'Clara', 'Sanchez', 'Femenino', 'Argentina', '1993-07-11', 'Alberdi 789', 'Salta', 'Salta', 'clara.sanchez@example.com', 038712345, 1),
(9, 90123456, 209012345612, 'Carlos', 'Profesor', 'Masculino', 'Argentina', '1987-09-15', 'Independencia 456', 'Neuquén', 'Neuquén', 'carlos@gmail.com', 029912345, 1),
(10, 12345679, 301234567912, 'Lucia', 'Torres', 'Femenino', 'Argentina', '1995-10-25', 'Mitre 123', 'Jujuy', 'Jujuy', 'lucia.torres@example.com', 038812345, 1);

-- Tabla usuario
INSERT INTO tpint_grupo_6_lab4.usuario (Id, NombreUsuario, Contraseña, TipoUsario, IdCliente, Activo) VALUES 
(1, 'juanperez', 'Perez1234', 0, 1, 1),
(2, 'mariagomez', 'gomez1234', 0, 2, 1),
(3, 'admin', 'admin', 1, 3, 1),
(4, 'anamarinez', 'marinez1234', 0, 4, 1),
(5, 'luisrodriguez', 'rodri321', 0, 5, 1),
(6, 'laurafernandez', 'ferlau123', 0, 6, 1),
(7, 'jorgegarcia', 'jor1234', 0, 7, 1),
(8, 'sofiaromero', 'sofiro23', 0, 8, 1),
(9, 'carlos', 'carlos', 0, 9, 1);

-- Tabla cuenta
INSERT INTO tpint_grupo_6_lab4.cuenta (Id, IdCliente, TipoCuenta, FechaCreacion, NumeroCuenta, CBU, Saldo, Activo) VALUES 
(1, 1, 1, '2024-12-11', 1001, '31001001', 10000, 1),
(2, 1, 2, '2024-12-11', 1002, '31001002', 10000, 1),
(3, 2, 1, '2024-12-11', 1003, '31005001', 10000, 1),
(4, 4, 1, '2024-12-11', 1006, '31004001', 10000, 1),
(6, 5, 2, '2024-12-11', 1007, '31005001', 10000, 1),
(7, 5, 1, '2024-12-11', 1008, '31005002', 10000, 1),
(8, 6, 1, '2024-12-11', 1009, '3106001', 10000, 1),
(9, 7, 2, '2024-12-11', 1010, '3107001', 10000, 1);

-- Tabla movimiento
INSERT INTO tpint_grupo_6_lab4.movimiento (Id, TipoMovimiento, FechaMovimiento, Importe, IdCuenta, Detalle) VALUES 
(1, 1, '2024-12-11', 10000, 1, 'Alta de cuenta'),
(2, 1, '2024-12-11', 10000, 2, 'Alta de cuenta'),
(3, 1, '2024-12-11', 10000, 3, 'Alta de cuenta'),
(4, 1, '2024-12-11', 10000, 4, 'Alta de cuenta'),
(5, 1, '2024-12-11', 10000, 5, 'Alta de cuenta'),
(6, 1, '2024-12-11', 10000, 6, 'Alta de cuenta'),
(7, 1, '2024-12-11', 10000, 7, 'Alta de cuenta'),
(8, 1, '2024-12-11', 10000, 8, 'Alta de cuenta'),
(9, 1, '2024-12-11', 10000, 9, 'Alta de cuenta'),
(10, 1, '2024-12-11', 10000, 10, 'Alta de cuenta');

-- Tabla Nacionalidades
INSERT INTO tpint_grupo_6_lab4.nacionalidades ( Pais) VALUES
( 'Argentina');

-- Tabla provincias
INSERT INTO tpint_grupo_6_lab4.provincias (IdNacionalidad, Provincia) VALUES
( 1, 'Buenos Aires'),
( 1, 'Santa Fe'),
( 1, 'Cordoba'),
( 1, 'Mendoza'),
( 1, 'Tucuman'),
( 1, 'Salta'),
( 1, 'Misiones'),
( 1, 'San Juan'),
( 1, 'San Luis');

-- Tabla localidades
INSERT INTO tpint_grupo_6_lab4.localidades ( Localiadad, IDProvincia) VALUES
('La Plata', 1),
('Rosario', 2),
('Cordoba', 3),
('Mendoza', 4),
('Tucuman', 5),
('Salta', 6),
('Posadas', 7),
('San Juan', 8),
('San Luis', 9);