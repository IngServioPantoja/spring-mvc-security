package co.com.sp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import co.com.sp.dto.CalculoDTO;
import co.com.sp.dto.PersonaDTO;

@Controller
public class FormController {
    

    //form.htm?verForm
    @RequestMapping(params = "verForm")
    public ModelAndView verFormulario(){
        ModelAndView mav = new ModelAndView("view"); //view.jsp
        PersonaDTO pdto = new PersonaDTO();
        pdto.setNombre("Carlos");
//        pdto.setApellido("Burgos");
//        pdto.setCorreo("cburgos@java.com");
        //Enviar desde Controller a JSP
        mav.addObject("objetPersonaDTOJSP", pdto);
        
        return mav;
    }
    
    //form.htm?guardarForm
    @RequestMapping(params = "guardarForm")
    public ModelAndView recibirObjeto(@ModelAttribute CalculoDTO p){
        ModelAndView mav = new ModelAndView("save");
        mav.addObject("pVal", p);
        return mav;
    }
    
    
}
