<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List"%>
<%@page import="servicio.Usuario"%>

<jsp:include page="nav.jsp" />

<!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Reporte/</span> Reporte de reservas</h4>

              <!-- Basic Layout & Basic with Icons -->
              <div class="row">
                <!-- Basic Layout -->
                <div class="col-xxl">
                <!-- Basic with Icons -->
                <div class="col-xxl">
                  <div class="card mb-4">
                    <div class="card-header d-flex align-items-center justify-content-between">
                      <h5 class="mb-0"></h5>
                      <small class="text-muted float-end"></small>
                    </div>
                        <div class="card-body">
                        <div class="row mb-3">
                          <div class="row mb-3">
                            <div>
                             <h3>Resumen General de Reservas</h3>
                                <table class="table table-bordered">
                                  <thead>
                                    <tr>
                                      <th>Mes</th>
                                      <th>Total Reservas</th>
                                      <th>Reservas Activas</th>
                                      <th>Reservas Canceladas</th>
                                      <th>Duración Promedio (horas)</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    <tr>
                                      <td>Mayo 2025</td>
                                      <td>150</td>
                                      <td>120</td>
                                      <td>20</td>
                                      <td>2.5</td>
                                    </tr>
                                    <!-- Más filas -->
                                  </tbody>
                                </table>
                            </div>
                          </div>
                        </div>
                      </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- / Content -->


<jsp:include page="footer.jsp" />
