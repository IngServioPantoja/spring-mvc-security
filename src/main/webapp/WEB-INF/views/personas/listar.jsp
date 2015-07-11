<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<link rel="stylesheet" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css">
	
	<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
</head>
<body>
	<header class="bg-primary">Sistema de gestión de alumnos
		<div style="float:right;">
			<c:url value="/j_spring_security_logout" var="logoutUrl" />
			<form action="${pageContext.request.contextPath}/j_spring_security_logout" method="post" id="logoutForm">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="submit" value="Salir" style="background-color: rgba(0,0,0,0); border: none;">
			</form>
		</div>	
	</header>
	<section style="text-align:center;margin:5px">
		<div style="text-align:left;margin:10px 0px">
			<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" id="botonModalAgregar">
			  Agregar
			</button>
		</div>
		<div class="panel panel-primary">
		  <div class="panel-heading">Personas</div>
		  <div class="panel-body" id="contenedorTablaPersonas">
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
		  </div>
		</div>
	</section>	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header bg-primary">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Agregar persona</h4>
	      </div>
			<div class="modal-body" style="overflow:auto;">
				<div id="contenedorAgregarPersona" style="overflow:auto;">
					<sf:form modelAttribute="personaDetalle" id="formPersona">
						<div class="form-group">
							<div class="col-xs-12 col-sm-6">
								<strong>identificacion:</strong>
							</div>
							<div class="col-xs-12 col-sm-6">
								<sf:input type="text" path="identificacion"  class="form-control" />
							</div>
							<div class="col-xs-12">
								<sf:errors path="identificacion"/>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-12 col-sm-6">
				            	<strong>Nombre:</strong>
				            </div>
				            <div class="col-xs-12 col-sm-6">
				            	<sf:input path="nombre" class="form-control" cssErrorClass="inputError" />
				            </div>
							<div class="col-xs-12">
								<sf:errors path="identificacion"/>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-12 col-sm-6">
				            	<strong>Apellido Paterno:</strong>
				            </div>
				            <div class="col-xs-12 col-sm-6">
				            	<sf:input path="apePaterno" class="form-control"  />
				            </div>
							<div class="col-xs-12">
								<sf:errors path="apePaterno"/>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-12 col-sm-6">
				            	<strong>Apellido Materno:</strong>
				            </div>
				            <div class="col-xs-12 col-sm-6">
				            	<sf:input path="apeMaterno" class="form-control" />
				            </div>
							<div class="col-xs-12">
								<sf:errors path="apeMaterno"/>
							</div>
						</div>
				        <div class="form-group">
				        	<div class="col-xs-12 col-sm-6">
				            	<strong>Email:</strong>
				            </div>
				            <div class="col-xs-12 col-sm-6">
				            	<sf:input path="email" class="form-control" />
				            </div>
							<div class="col-xs-12">
								<sf:errors path="email"/>
							</div>
				        </div>
				        <div class="form-group">
				        	<div class="col-xs-12 col-sm-6">
				            	<strong>Telefono:</strong>
				            </div>
				            <div class="col-xs-12 col-sm-6">
				            	<sf:input path="telefono" class="form-control" />
				            </div>
							<div class="col-xs-12">
								<sf:errors path="telefono"/>
							</div>
				        </div>
				        <div class="form-group">
				        	<div class="col-xs-12 col-sm-6">
				            	<strong>Genero:</strong>
				            </div>
				            <div class="col-xs-12 col-sm-6">
				            	<sf:select path="genero.id" class="form-control" items="${generos}" itemValue="id" itemLabel="descripcion"  required="required"/>
				            </div>
							<div class="col-xs-12">
								<sf:errors path="genero.id"/>
							</div>
				        </div>
						<input type="submit" class="hidden" id="enviarPersona" value="enviar">
						<script type="text/javascript">
					    	$(document).ready( function () {
							    $("#formPersona").submit(function(e){
									e.preventDefault();
									$.ajax({
								        url:"personas?agregarPersona",
								        type: "POST",
								        data: $("#formPersona").serialize(),
								        beforeSend: function(){
								            $("#estadoGuardarError").hide();
								            $("#estadoGuardarExito").hide();
								            $("#estadoGuardarProceso").show();
								        },
								        success: function(respuesta){
								        	var mi = $(respuesta);
								        	var input = mi.find("#error");
											var resultado = input.val();
											if(resultado == 'p'){
									            $("#contenedorAgregarPersona").html(respuesta);
								            	$("#estadoGuardarError").show();
											}else{
									            $("#estadoGuardarExito").show();
			            						$("#estadoGuardarError").hide();
								            	$("#estadoGuardarProceso").hide();
									            $("#formPersona").get(0).reset();
									            $("#contenedorTablaPersonas").html(respuesta);
											}
								        },
								        complete: function(respuesta){
								            $("#estadoGuardarProceso").hide();
								        },
								        error: function(respuesta){
								            $("#estadoGuardarError").show();
								        }
								        
							    	});
					    		});
					   		});
					   	</script>
	     		 </sf:form>
		       </div>
		        <div class="clearfix"style="margin: 10px auto;"></div>
				<div class="alert alert-success alert-dismissible" id="estadoGuardarExito" role="alert" style="display:none;">Se ha guardado con exito</div>  
				<div class="alert alert-danger alert-dismissible" id="estadoGuardarError" role="alert" style="display:none;">Ha ocurrido un error al guardar</div>  
				<div class="alert alert-info alert-dismissible" id="estadoGuardarProceso" role="alert" style="display:none;">Se esta procesando</div>  
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
				<label for="enviarPersona" class="btn btn-primary" id="labelGuardar">Guardar</label>
			</div>
	    </div>
	  </div>
	</div>
	<script type="text/javascript">
		
    	$(document).ready( function () {
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
</body>
</html>