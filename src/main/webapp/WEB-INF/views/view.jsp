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
        <aprendejava:form modelAttribute="objetPersonaDTOJSP" method="POST" action="form.htm?guardarForm">
            <table>
                <tr>
                    <td>Nombre:</td>
                    <td><aprendejava:input path="nombre" /></td>
                </tr>
                <tr>
                    <td>Apellido:</td>
                    <td><aprendejava:input path="apellido" /></td>
                </tr>
                <tr>
                    <td>Correo:</td>
                    <td><aprendejava:input path="correo" /></td>
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
