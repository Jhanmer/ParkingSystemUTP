<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="nav.jsp" />

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4">Confirmación de Reserva</h4>

    <div class="card shadow-sm mx-auto" style="max-width: 600px;">
      <div class="card-body text-center">

        <!-- Simulación de reserva exitosa -->
        <div class="alert alert-success" role="alert">
          <i class='bx bx-check-circle bx-lg text-success mb-3'></i>
          <h4 class="alert-heading">¡Reserva Exitosa!</h4>
          <p>Tu estacionamiento ha sido reservado con éxito.</p>
          <hr>
          <p class="mb-0">
            <strong>Número de Estacionamiento:</strong> <span class="fw-bold fs-5">P-17</span><br>
            <strong>ID de Reserva:</strong> 100289<br>
            <strong>Fecha:</strong> 2025-07-06<br>
            <strong>Hora de Inicio:</strong> 08:15:00<br>
            <strong>Hora de Fin:</strong> 09:15:00<br>
            <strong>Estado:</strong> Confirmado
          </p>
        </div>

        <a href="mireserva.jsp" class="btn btn-primary mt-3">Ver Mis Reservas</a>

        <!-- Simulación de error: descomenta para probar -->
        <%-- 
        <div class="alert alert-danger" role="alert">
          <i class='bx bx-x-circle bx-lg text-danger mb-3'></i>
          <h4 class="alert-heading">¡Error al Reservar!</h4>
          <p>No se pudo completar tu reserva. Esto puede deberse a que no hay estacionamientos disponibles para la fecha y hora seleccionadas, o a un problema interno.</p>
          <p class="mb-0">Por favor, intenta de nuevo o contacta a soporte.</p>
        </div>
        <a href="ReservarEstacionamiento.jsp" class="btn btn-secondary mt-3">Intentar de Nuevo</a>
        --%>

      </div>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp" />
