package Excepciones;

public class Contrase�aDiferente extends Exception{
	private static final long serialVersionUID = 1L;
	public Contrase�aDiferente() {	
	}

	@Override
	public String getMessage() {
		return "Las contrase�as no son�iguales!";
	}
}

