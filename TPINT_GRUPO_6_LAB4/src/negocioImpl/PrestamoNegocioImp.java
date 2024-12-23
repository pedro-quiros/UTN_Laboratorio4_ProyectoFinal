package negocioImpl;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import Entidades.Cuota;
import Entidades.Movimiento;
import Entidades.Prestamo;
import daoImp.MovimientoDaoImp;
import daoImp.PrestamoDaoImp;
import negocio.PrestamoNegocio;

public class PrestamoNegocioImp implements PrestamoNegocio {
	private PrestamoDaoImp prestamoDao = new PrestamoDaoImp();
	private MovimientoDaoImp movimientoDao = new MovimientoDaoImp();

	@Override
	public boolean realizarPagoCuotaConMovimiento(int cuotaId, int cuentaId, float monto) {
	    boolean exito = false;

	    try {
	        // Validar saldo de la cuenta antes de proceder
	        float saldoActual = movimientoDao.ObtenerSaldoPorIdCuenta(cuentaId);
	        System.out.println("Saldo actual: " + saldoActual);  // Imprimir saldo actual
	        System.out.println("Monto a pagar: " + monto);         // Imprimir monto

	        // Verificar si el saldo es suficiente para realizar el pago
	        if (saldoActual < monto) {
	            System.out.println("Saldo insuficiente para realizar el pago.");
	            return false;
	        }

	        // Crear el movimiento de pago
	        Movimiento movimiento = new Movimiento();
	        movimiento.setImporte(-monto); // D�bito
	        movimiento.setTipoMovimiento(3); // C�digo para pago de cuota
	        movimiento.setDetalle("Pago de cuota (ID Cuota: " + cuotaId + ")");

	        // Insertar movimiento de pago
	        boolean movimientoRegistrado = movimientoDao.insertarMovimientoPagoCuota(movimiento, cuentaId);

	        // Solo actualizar la cuota si el movimiento fue registrado con �xito
	        if (movimientoRegistrado) {
	            boolean cuotaActualizada = prestamoDao.actualizarEstadoCuota(cuotaId, true);
	            if (cuotaActualizada) {
	                exito = true;
	                System.out.println("Pago de cuota realizado exitosamente.");
	            } else {
	                System.out.println("Error al actualizar el estado de la cuota.");
	            }
	        } else {
	            System.out.println("Error al registrar el movimiento.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("Error durante el proceso de pago de cuota.");
	    }

	    return exito;
	}
	
	@Override
	public boolean confirmarPrestamoConMovimiento(int idPrestamo, int idCuenta) {
	    boolean exito = false;

	    try {
	        // 1. Confirmar el pr�stamo
	        boolean confirmacionExitosa = prestamoDao.confirmacionPrestamo(idPrestamo);

	        if (confirmacionExitosa) {
	            // 2. Obtener el importe del pr�stamo
	            float importePrestamo = prestamoDao.obtenerImportePrestamo(idPrestamo);

	            // 3. Crear el movimiento para registrar el alta del pr�stamo
	            Movimiento movimiento = new Movimiento();
	            movimiento.setImporte(importePrestamo);  
	            movimiento.setTipoMovimiento(2); // Tipo 2: Alta de pr�stamo
	            movimiento.setDetalle("Alta de pr�stamo: Confirmado"); // Detalle del movimiento

	            // 4. Registrar el movimiento llamando al DAO
	            boolean movimientoInsertado = movimientoDao.insertarMovimientoAltaPrestamoConfirmado(movimiento, idCuenta);

	            if (movimientoInsertado) {
	                // 5. Acreditar el pr�stamo en la cuenta
	                boolean prestamoAcreditado = prestamoDao.CargarPrestamoEnCuenta(idCuenta, importePrestamo);

	                if (prestamoAcreditado) {
	                    System.out.println("El pr�stamo y el movimiento fueron procesados exitosamente.");
	                    exito = true;
	                } else {
	                    System.out.println("Error al acreditar el pr�stamo en la cuenta.");
	                }
	            } else {
	                System.out.println("Error al registrar el movimiento.");
	            }
	        } else {
	            System.out.println("Error al confirmar el pr�stamo.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return exito;
	}


	@Override
	public boolean solicitarPrestamo(Prestamo prestamo) {
	    boolean prestamoExitoso = false;

	    float tasaInteres = calcularTasaInteres(prestamo.getCantCuo());
	    if (tasaInteres == -1) {
	        System.out.println("N�mero de cuotas no v�lido.");
	        return false;
	    }

	    float montoConInteres = prestamo.getImporteCliente() * (1 + tasaInteres);

	    // Generamos las cuotas para el pr�stamo
	    List<Cuota> cuotas = generarCuotas(prestamo, montoConInteres);

	    // Realizamos la inserci�n del pr�stamo y las cuotas en el DAO
	    try {
	        prestamoExitoso = prestamoDao.insertarPrestamo(prestamo, cuotas);
	        if (prestamoExitoso) {
	            System.out.println("El pr�stamo y sus cuotas se han insertado correctamente.");
	        }
	    } catch (Exception e) {
	        System.out.println("Error al insertar el pr�stamo y las cuotas.");
	        e.printStackTrace();
	    }

	    return prestamoExitoso;
	}

	public List<Cuota> generarCuotas(Prestamo prestamo, float montoConInteres) {
	    List<Cuota> cuotas = new ArrayList<>();
	    
	    // Calculamos el monto de cada cuota
	    float montoCuota = montoConInteres / prestamo.getCantCuo();

	    // Generamos las cuotas
	    for (int i = 1; i <= prestamo.getCantCuo(); i++) {
	        Cuota cuota = new Cuota();
	        cuota.setNumeroCuota(i);
	        cuota.setMonto(montoCuota);
	        cuota.setFechaPago(LocalDate.now().plusMonths(i)); // Genera la fecha de pago para cada cuota
	        cuotas.add(cuota);
	    }
	    return cuotas;
	}

	private float calcularTasaInteres(int cantidadCuotas) {
	    // Calcula la tasa de inter�s seg�n la cantidad de cuotas
	    switch (cantidadCuotas) {
	        case 1: return 0.0f;   // Sin inter�s
	        case 3: return 0.05f;  // 5% inter�s
	        case 6: return 0.10f;  // 10% inter�s
	        case 9: return 0.15f;  // 15% inter�s
	        case 12: return 0.20f; // 20% inter�s
	        default:
	            System.out.println("Cantidad de cuotas no v�lida");
	            return -1; // Indicamos que la cantidad de cuotas no es v�lida
	    }
	}

	@Override
	public ArrayList<Prestamo> ListPrestamosPedidos() {
		return prestamoDao.ListPrestamosPedidos();
	}

	@Override
	public boolean actualizarConfirmacionPrestamo(int idPrestamo, int confirmacion) {
		return prestamoDao.actualizarConfirmacionPrestamo(idPrestamo,confirmacion);
	}

	@Override
	public ArrayList<Prestamo> ListPrestamosPedidosAutorizados() {
		
		return prestamoDao.ListPrestamosPedidosAutorizados();
	}
	
	public ArrayList<Prestamo> obtenerPrestamosEnEspera(int idCliente) {
		return prestamoDao.obtenerPrestamosEnEspera(idCliente);
	}  
	
	@Override
	public boolean CargarPrestamoEnCuenta(int idcuenta, float monto) {
		return prestamoDao.CargarPrestamoEnCuenta(idcuenta,monto);
	}

	@Override
	public double obtenerTotalPrestamosConfirmados(int idCliente) {
		return prestamoDao.obtenerTotalPrestamosConfirmados(idCliente);
	}

	@Override
	public List<Prestamo> obtenerPrestamosConfirmados(int idCliente) {
		return prestamoDao.obtenerPrestamosConfirmados(idCliente);
	}

	@Override
	public List<Cuota> obtenerCuotas(int idCliente, int idPrestamo) {
		return prestamoDao.obtenerCuotas(idCliente,idPrestamo);
	}


	@Override
	public double obtenerSumaCuotasPendientes(int idCliente) {
		return prestamoDao.obtenerSumaCuotasPendientes(idCliente);
	}

	@Override
	public ArrayList<Prestamo> filtrarClienteXImporte(String orden) {
		return prestamoDao.filtrarClienteXImporte(orden);
	}

	@Override
	public ArrayList<Prestamo> filtrarClienteXImporteConfirmado(String orden) {
		return prestamoDao.filtrarClienteXImporteConfirmado(orden);
	}

	@Override
	public boolean realizarPagoCuota(int cuotaId, int cuentaId, float monto) {
		return prestamoDao.realizarPagoCuota(cuotaId,cuentaId,monto);
	}
	

	public boolean denegarPrestamo(int idPrestamo) {
		return prestamoDao.denegarPrestamo(idPrestamo);
	}

}
