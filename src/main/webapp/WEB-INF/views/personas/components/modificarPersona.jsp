<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<sf:form modelAttribute="personaDetalle" id="formPersona">
	<input type="hidden" value="p" id="error">
	<sf:input type="hidden" path="idPersona"/>
	<div class="form-group form-group-overflow">
		<div class="col-xs-12 col-sm-6">
			<strong>identificacion:</strong>
		</div>${consulta}
		<div class="col-xs-12 col-sm-6">
			<sf:input type="text" path="identificacion" class="form-control"/>
		</div>
		<div class="col-xs-12">
			<sf:errors path="identificacion" cssClass="error" />
		</div>
	</div>
	<div class="form-group form-group-overflow">
		<div class="col-xs-12 col-sm-6">
			<strong>Nombre:</strong>
		</div>
		<div class="col-xs-12 col-sm-6">
			<sf:input path="nombre" class="form-control"/>
		</div>
		<div class="col-xs-12">
			<sf:errors path="nombre" cssClass="error" />
		</div>
	</div>
	<div class="form-group form-group-overflow">
		<div class="col-xs-12 col-sm-6">
			<strong>Apellido Paterno:</strong>
		</div>
		<div class="col-xs-12 col-sm-6">
			<sf:input path="apePaterno" class="form-control" />
		</div>
		<div class="col-xs-12">
			<sf:errors path="apePaterno" cssClass="error" />
		</div>
	</div>
	<div class="form-group form-group-overflow">
		<div class="col-xs-12 col-sm-6">
			<strong>Apellido Materno:</strong>
		</div>
		<div class="col-xs-12 col-sm-6">
			<sf:input path="apeMaterno" class="form-control" />
		</div>
		<div class="col-xs-12">
			<sf:errors path="apeMaterno" cssClass="error" />
		</div>
	</div>
	<div class="form-group form-group-overflow">
		<div class="col-xs-12 col-sm-6">
			<strong>Email:</strong>
		</div>
		<div class="col-xs-12 col-sm-6">
			<sf:input path="email" class="form-control" />
		</div>
		<div class="col-xs-12">
			<sf:errors path="email" cssClass="error" />
		</div>
	</div>
	<div class="form-group form-group-overflow">
		<div class="col-xs-12 col-sm-6">
			<strong>Telefono:</strong>
		</div>
		<div class="col-xs-12 col-sm-6">
			<sf:input path="telefono" class="form-control" />
		</div>
		<div class="col-xs-12">
			<sf:errors path="telefono" cssClass="error" />
		</div>
	</div>
	<div class="form-group form-group-overflow">
		<div class="col-xs-12 col-sm-6">
			<strong>Genero:</strong>
		</div>
		<div class="col-xs-12 col-sm-6">
			<sf:select path="genero.id" class="form-control" items="${generos}"
				itemValue="id" itemLabel="descripcion" />
		</div>
		<div class="col-xs-12">
			<sf:errors path="genero.id" cssClass="error" />
		</div>
	</div>

	<input type="submit" class="hidden" id="enviarPersona" value="enviar">
	<script type="text/javascript">
		$(document).ready(function() {
			$("#formPersona").submit(function(e) {
				e.preventDefault();
				$.ajax({
					url : "personas?agregarPersona",
					type : "POST",
					data : $("#formPersona").serialize(),
					beforeSend : function() {
						$("#estadoGuardarError").hide();
						$("#estadoGuardarExito").hide();
						$("#estadoGuardarProceso").show();
					},
					success : function(respuesta) {
						var mi = $(respuesta);
						var input = mi.find("#error");
						var resultado = input.val();
						if (resultado == 'p') {
							$("#contenedorAgregarPersona").html(respuesta);
							$("#estadoGuardarError").show();
						} else {
							$("#estadoGuardarExito").show();
							$("#estadoGuardarError").hide();
							$("#estadoGuardarProceso").hide();
							$("#contenedorTablaPersonas").html(respuesta);
						}
					},
					complete : function(respuesta) {
						$("#estadoGuardarProceso").hide();
					},
					error : function(respuesta) {
						$("#estadoGuardarError").show();
					}

				});
			});
		});
	</script>
</sf:form>