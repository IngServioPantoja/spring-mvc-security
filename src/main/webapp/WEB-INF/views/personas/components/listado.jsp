<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<table class="table table-striped" id="idTablaPersonas">
	<thead>
		<tr>
			<th>Identificacion</th>
			<th>Nombre</th>
			<th>Apellido</th>
			<th>Acciones</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="persona" items="${personas}">
			<tr>
				<td>${persona.identificacion}</td>
				<td>${persona.nombre}</td>
				<td>${persona.apeMaterno}</td>
				<td style="max-width:100px;">
				
					<sf:form modelAttribute="persona"  method="POST" style="display:inline-block;" class="formConsultarPersona">
						<input type="hidden" value="consultar" name="accion">
						<input type="hidden" name="idPersona" value="${persona.idPersona}">
						<input type="submit" value="Consultar" class="btn btn-primary" >
					</sf:form>
					
					<sf:form modelAttribute="persona" method="POST" style="display:inline-block;" class="formModificarPersona">
						<input type="hidden" value="modificar" name="accion">
						<input type="hidden" name="idPersona" value="${persona.idPersona}">
						<input type="submit" value="Modificar" class="btn btn-success" >
					</sf:form>
					
					<form method="POST" onsubmit="return confirm('Realemte desea eliminar este registro');" 
						 style="display:inline-block;">
						<input type="hidden" value="eliminar" name="accion">
						<input type="hidden" name="idPersona" value="${persona.idPersona}">
						<input type="submit" value="Eliminar" class="btn btn-danger" >
					</form>
				
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<input type="hidden" value="t" id="error">
<script type="text/javascript">
   	$(document).ready( function () {
	    $('#idTablaPersonas').DataTable();
    	$(".formConsultarPersona").submit(function(e){
			e.preventDefault();
    		$.ajax({
		        url:"personas?detallarPersona",
		        type: "POST",
		        data: $(this).serialize(),
		        success: function(respuesta){
		        	$("#labelGuardar").hide();
		            $("#contenedorAgregarPersona").html(respuesta);
					
		        },
		        complete: function(respuesta){
    				$('#myModal').modal('show');
		        },
		        error: function(respuesta){
		            $("#estadoGuardarError").show();
		        }
		        
	    	});
    	});
    	
    	$(".formModificarPersona").submit(function(e){
			e.preventDefault();
    		$.ajax({
		        url:"personas?detallarPersona",
		        type: "POST",
		        data: $(this).serialize(),
		        success: function(respuesta){
		            $("#contenedorAgregarPersona").html(respuesta);
					
		        },
		        complete: function(respuesta){
		        	$("#labelGuardar").show();
    				$('#myModal').modal('show');
		        },
		        error: function(respuesta){
		            $("#estadoGuardarError").show();
		        }
		        
	    	});
    	});
    	$("#botonModalAgregar").click(function(e){
            $("#estadoGuardarError").hide();
            $("#estadoGuardarExito").hide();
    		$('#myModal').modal('show');
    	});
	    function formSubmit() {
			document.getElementById("logoutForm").submit();
		}
	});
</script>