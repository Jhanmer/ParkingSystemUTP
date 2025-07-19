<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@page import="java.util.List"%>

<jsp:include page="nav.jsp" />

<!-- Content wrapper -->
<!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->        
            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Reservas /</span> Tu Reserva</h4>
              <div class="col-lg-8 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="col-sm-7">
                        <div class="card-body">
                          <h5 class="card-title text-primary">¡Hola 
                              <% 
                                  String nombreUsuario = (String) session.getAttribute("usuario");
                                  out.print(nombreUsuario != null ? nombreUsuario : "Usuario"); 
                              %>!
                          </h5>
                          
                          <p class="mb-4">
                              Recuerda que la <span class="fw-bold">puntualidad</span> es una muestra de respeto hacia los demás.
                          </p>
                          <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                              <img src="assets/img/icons/unicons/chart-success.png" alt="Credit Card" class="rounded">
                            </div>
                          </div>
                          
                          <c:choose>
                              <c:when test="${not empty historialReservas && historialReservas.size() > 0}">
                                  <c:set var="ultimaReserva" value="${historialReservas[0]}" />
                                  <c:if test="${ultimaReserva.estado eq 'reservada'}">
                                      <span class="d-block mb-1">Tu Reserva de Estacionamiento es:</span>
                                      <h3 class="card-title text-nowrap mb-2">${ultimaReserva.fecha}</h3>
                                      <h3 class="card-title text-nowrap mb-2">${ultimaReserva.horaInicio} - ${ultimaReserva.horaFin}</h3>
                                  </c:if>
                                  <c:if test="${ultimaReserva.estado ne 'reservada'}">
                                      <span class="d-block mb-1">No tienes reservas activas</span>
                                      <h3 class="card-title text-nowrap mb-2">¡Haz tu próxima reserva!</h3>
                                  </c:if>
                              </c:when>
                              <c:otherwise>
                                  <span class="d-block mb-1">No tienes reservas registradas</span>
                                  <h3 class="card-title text-nowrap mb-2">¡Haz tu primera reserva!</h3>
                              </c:otherwise>
                          </c:choose>
                        </div>
                          
                        </div>
                      </div>
                      <div class="col-sm-5 text-center text-sm-left">
                        <div class="card-body pb-0 px-0 px-md-4">
                          <img src="assets/img/illustrations/carro_reserva.jpg" height="140" alt="View Badge User" data-app-dark-img="illustrations/man-with-laptop-dark.png" data-app-light-img="illustrations/man-with-laptop-light.png">
                          <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty historialReservas && historialReservas.size() > 0}">
                                    <c:set var="ultimaReserva" value="${historialReservas[0]}" />
                                    <c:if test="${ultimaReserva.estado eq 'reservada'}">
                                        <div class="text-light small fw-semibold mb-1">Estado de Reserva</div>
                                        <div class="progress mb-3">
                                          <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
                                                Reserva Activa
                                        </div>
                                        </div>
                                        <span class="badge rounded-pill bg-success">Estás reservando el estacionamiento: ${ultimaReserva.numeroEstacionamiento}</span>
                                    </c:if>
                                    <c:if test="${ultimaReserva.estado ne 'reservada'}">
                                        <div class="text-light small fw-semibold mb-1">Estado</div>
                                        <div class="progress mb-3">
                                          <div class="progress-bar bg-secondary" role="progressbar" style="width: 100%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                                Sin reservas activas
                                        </div>
                                        </div>
                                        <span class="badge rounded-pill bg-secondary">No hay estacionamiento reservado</span>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-light small fw-semibold mb-1">Estado</div>
                                    <div class="progress mb-3">
                                      <div class="progress-bar bg-secondary" role="progressbar" style="width: 100%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                                            Sin reservas
                                    </div>
                                    </div>
                                    <span class="badge rounded-pill bg-secondary">No hay estacionamiento reservado</span>
                                </c:otherwise>
                            </c:choose>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              <!-- Basic Bootstrap Table -->
              <div class="card">
                <h5 class="card-header">Historial de Reserva</h5>
                <div class="table-responsive text-nowrap">
                  <table class="table">
                    <thead>
                        <tr>
                          <th>ID</th>
                          <th>Estacionamiento</th>
                          <th>Fecha</th>
                          <th>Hora Inicio</th>
                          <th>Hora Fin</th>
                          <th>Estado</th>
                        </tr>
                      </thead>
                    <tbody class="table-border-bottom-0">
                        <c:choose>
                          <c:when test="${not empty historialReservas}">
                            <c:forEach var="reserva" items="${historialReservas}">
                                <c:choose>
                                  <c:when test="${reserva.estado eq 'asistio'}">
                                    <c:set var="estadoClase" value="bg-label-success" />
                                  </c:when>
                                  <c:when test="${reserva.estado eq 'cancelada'}">
                                    <c:set var="estadoClase" value="bg-label-warning" />
                                  </c:when>
                                  <c:when test="${reserva.estado eq 'no_asistio' or reserva.estado eq 'culmino_tiempo'}">
                                    <c:set var="estadoClase" value="bg-label-danger" />
                                  </c:when>
                                  <c:otherwise>
                                    <c:set var="estadoClase" value="bg-label-secondary" />
                                  </c:otherwise>
                                </c:choose>

                                <tr>
                                  <td><strong>${reserva.id}</strong></td>
                                  <td>${reserva.numeroEstacionamiento}</td>
                                  <td>${reserva.fecha}</td>
                                  <td>${reserva.horaInicio}</td>
                                  <td>${reserva.horaFin}</td>
                                  <td>
                                    <span class="badge ${estadoClase}">${reserva.estado}</span>
                                  </td>
                                </tr>
                              </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <tr>
                              <td colspan="6" class="text-center">No hay historial de reservas.</td>
                            </tr>
                          </c:otherwise>
                        </c:choose>
                      </tbody>

                  </table>
                </div>
              </div>
              <!--/ Basic Bootstrap Table -->

            </div>
            <!-- / Content -->


<jsp:include page="footer.jsp" />