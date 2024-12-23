package Entidades;

public class Usuario {
	private int id;
	private String usuario;
	private String contrase�a;
	private int tipoUsuario;
	private int IdCliente;
	
	public Usuario ()
	{
		id=0;
		usuario="";
		contrase�a="";
		tipoUsuario =0 ;
		IdCliente = 0;
	}
	
    public Usuario(int id, String usuario, String contrase�a, int tipoUsuario, int idCliente, boolean activo) {
		super();
		this.id = id;
		this.usuario = usuario;
		this.contrase�a = contrase�a;
		this.tipoUsuario = tipoUsuario;
		IdCliente = idCliente;
		Activo = activo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdCliente() {
		return IdCliente;
	}
	public void setIdCliente(int idCliente) {
		IdCliente = idCliente;
	}

	private boolean Activo;
	
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getContrase�a() {
		return contrase�a;
	}
	public void setContrase�a(String contrase�a) {
		this.contrase�a = contrase�a;
	}
	public int getTipoUsuario() {
	    return tipoUsuario;
	}

	public void setTipoUsuario(int tipoUsuario) {
	    this.tipoUsuario = tipoUsuario;
	}
	public boolean getActivo() {
		return Activo;
	}
	
	public void setActivo(boolean Activo) {
	    this.Activo = Activo;
	}	
}
