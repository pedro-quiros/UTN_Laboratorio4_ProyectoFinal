package negocio;

public class Provincias {
	private int idProvincia; // ID de la provincia
    private int idNacionalidad; // ID de la nacionalidad asociada
    private String nombre; // Nombre de la provincia

    // Constructor vac�o
    public Provincias() {
    }

    // Constructor con par�metros
    public Provincias(int idProvincia, int idNacionalidad, String nombre) {
        this.idProvincia = idProvincia;
        this.idNacionalidad = idNacionalidad;
        this.nombre = nombre;
    }

    // Getters y Setters
    public int getIdProvincia() {
        return idProvincia;
    }

    public void setIdProvincia(int idProvincia) {
        this.idProvincia = idProvincia;
    }

    public int getIdNacionalidad() {
        return idNacionalidad;
    }

    public void setIdNacionalidad(int idNacionalidad) {
        this.idNacionalidad = idNacionalidad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    // M�todo toString para mostrar informaci�n
    @Override
    public String toString() {
        return "nombre";
    }

}
