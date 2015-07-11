package co.com.sp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import co.com.sp.dto.CalculoDTO;

@Controller
public class CalculadoraController {
    
    //form.htm?verForm
    @RequestMapping(params = "ingresar")
    public ModelAndView verFormulario(){
        ModelAndView mav = new ModelAndView("calculadora/calculadora"); //view.jsp
        CalculoDTO calculo = new CalculoDTO();
        //Enviar desde Controller a JSP
        mav.addObject("calculo", calculo);
        
        return mav;
    }
    
    //form.htm?guardarForm
    @RequestMapping(params = "operar")
    public ModelAndView recibirObjeto(@ModelAttribute CalculoDTO c){
        ModelAndView mav = new ModelAndView("calculadora/resultado");
        double resultado = 0.0;
        if(c.getOperacion().equals("s")){
            resultado = Integer.parseInt(c.getValor1())+Integer.parseInt(c.getValor2());
        }else if(c.getOperacion().equals("r")){
            resultado = Integer.parseInt(c.getValor1())-Integer.parseInt(c.getValor2());
        }else if(c.getOperacion().equals("d")){
            resultado = Integer.parseInt(c.getValor1())/Integer.parseInt(c.getValor2());
        }else{
            resultado = Integer.parseInt(c.getValor1())*Integer.parseInt(c.getValor2());
        }
        mav.addObject("resultado", resultado);
        return mav;
    }
    
    
}
