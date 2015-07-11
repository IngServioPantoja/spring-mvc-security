<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="aprendejava" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Registrar persona</h1>
        <aprendejava:form modelAttribute="calculo" method="POST" action="calculadora.htm?operar">
            <table>
                <tr>
                    <td>valor 1:</td>
                    <td><aprendejava:input path="valor1" /></td>
                </tr>
                <tr>
                    <td>valor 2:</td>
                    <td><aprendejava:input path="valor2" /></td>
                </tr>
                <tr>
                    <td>Operación:</td>
                    <td>
                        <aprendejava:select path="operacion">
                            <aprendejava:option value="s">Sumar</aprendejava:option>
                            <aprendejava:option value="r">Restar</aprendejava:option>
                            <aprendejava:option value="m">Multiplicar</aprendejava:option>
                            <aprendejava:option value="d">Dividir</aprendejava:option>
                        </aprendejava:select>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" value="Enviar" />
                    </td>
                </tr>
            </table>            
        </aprendejava:form>
    </body>
</html>
