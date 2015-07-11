package co.com.sp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import co.com.sp.capadominio.ParametroPersona;
import co.com.sp.capadominio.Persona;
import co.com.sp.capaservicio.ParametroPersonaService;
import co.com.sp.capaservicio.PersonaService;
import co.com.sp.capaservicio.excepciones.BusinessException;

@Controller
@RequestMapping("/private/personas")
public class PersonaController {
    
	@Autowired
	private PersonaService personaService;
	
	@Autowired
	private ParametroPersonaService parametroPersonaService;
	
	final Long ID_TIPO_PARAMETRO_PERSONA = (long) 1;
	
	@RequestMapping(method = RequestMethod.GET)
    public ModelAndView listar(){
        ModelAndView mav = new ModelAndView("/personas/listar"); //view.jsp
        List<ParametroPersona> generos = new ArrayList<ParametroPersona>();
        List<Persona> lstPersonas = new ArrayList<Persona>();
        try {
    		generos = parametroPersonaService.findByTipo(ID_TIPO_PARAMETRO_PERSONA);
			lstPersonas = personaService.listar();
		} catch (BusinessException e) {
			System.out.println("Error en la capa web consultando Personas "+e);
		}
        Persona persona = new Persona();
        mav.addObject("personas",lstPersonas);
        mav.addObject("personaDetalle",persona);
        mav.addObject("generos",generos);
        return mav;
    }
    
    @RequestMapping(params = "agregarPersona")
    public ModelAndView agregarPersona(@Valid @ModelAttribute("personaDetalle") Persona p, BindingResult valid) throws Exception{
        ModelAndView mav = null;
        if(valid.hasErrors()){
        	List<ParametroPersona> generos = new ArrayList<ParametroPersona>();
    		generos = parametroPersonaService.findByTipo(ID_TIPO_PARAMETRO_PERSONA);
        	mav = new ModelAndView("/personas/components/persona");
            mav.addObject("personaDetalle",p);
            mav.addObject("generos",generos);
        }else{
        	try {
	            List<Persona> lstPersonas = new ArrayList<Persona>();
	    		mav = new ModelAndView("/personas/components/listado");
				personaService.insertar(p);
				lstPersonas = personaService.listar();
	            mav.addObject("personas",lstPersonas);
        	} catch (BusinessException e) {
    			System.out.println("Error en la capa web consultando Personas "+e);
        		throw new Exception("Se ha presentado un error al insertar el registro");
    		}
        }
        return mav;
    }
    
    
    @RequestMapping(params = "detallarPersona")
    public ModelAndView detallarPersona(@ModelAttribute Persona p, @RequestParam("accion") String accion) throws Exception{
        ModelAndView mav = new ModelAndView("/personas/components/persona");
    	List<ParametroPersona> generos = new ArrayList<ParametroPersona>();
        try { 
    		generos = parametroPersonaService.findByTipo(ID_TIPO_PARAMETRO_PERSONA);
			p = personaService.encontrarPorIdCompleta(p.getIdPersona());
		} catch (BusinessException e) {
			System.out.println("Error en la capa web consultando una persona "+e);
    		throw new Exception("Se ha presentado un error consultando una persona");
		}
        if(accion.equals("consultar")){
        	mav = new ModelAndView("/personas/components/consultarPersona");
        }else{
        	mav = new ModelAndView("/personas/components/modificarPersona");
        }
        mav.addObject("personaDetalle",p);
        mav.addObject("generos",generos);
        return mav;
    }
}
