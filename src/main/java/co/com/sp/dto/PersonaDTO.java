package co.com.sp.dto;


import co.com.sp.capadominio.ParametroPersona;
import co.com.sp.capadominio.Persona;

public class PersonaDTO extends Persona {

	private static final long serialVersionUID = -1971816001641262269L;
	
    private Long generoDTO;

    public PersonaDTO() {
    }

	public Long getGeneroDTO() {
		return generoDTO;
	}

	public void setGeneroDTO(Long generoDTO) {
		
		this.generoDTO = generoDTO;
		this.setGenero(new ParametroPersona(generoDTO));
	}

    

}
