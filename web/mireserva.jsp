<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                          <h5 class="card-title text-primary">Hola !</h5>
                          
                          <p class="mb-4">
                              Recuerda que la <span class="fw-bold">puntualidad</span> es una muestra de respeto hacia los demás.
                          </p>
                          <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                              <img src="assets/img/icons/unicons/chart-success.png" alt="Credit Card" class="rounded">
                            </div>
                          </div>
                          <span class="d-block mb-1">Tu Reserva de Estacionamiento es:</span>
                          <h3 class="card-title text-nowrap mb-2">Hoy 05 de Junio</h3>
                          <div class="card-title d-flex align-items-start justify-content-between">
                          </div>
                          <h3 class="card-title text-nowrap mb-2">08:15 p.m. a 09:15 p.m.</h3>
                        </div>
                          
                        </div>
                      </div>
                      <div class="col-sm-5 text-center text-sm-left">
                        <div class="card-body pb-0 px-0 px-md-4">
                          <img src="assets/img/illustrations/carro_reserva.jpg" height="140" alt="View Badge User" data-app-dark-img="illustrations/man-with-laptop-dark.png" data-app-light-img="illustrations/man-with-laptop-light.png">
                          <div class="card-body">
                            <div class="text-light small fw-semibold mb-1">Tiempo</div>
                            <div class="progress mb-3">
                              <div class="progress-bar" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
                                    2 horas y 30 minutos
                            </div>
                                
                            </div>
                            <span class="badge rounded-pill bg-success">Estas ocupado el estacionamiento: B5</span>
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
                        <th>Número de Reserva</th>
                        <th>Lugar Estacionamiento</th>
                        <th>Fecha de Reserva</th>
                        <th>Estado</th>
                        <th hidden>Actions</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                      <tr>
                        <td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong>004</strong></td>
                        <td>B5</td>
                        <td>30/05/2025
                        </td>
                        <td><span class="badge bg-label-primary me-1">Active</span></td>
                        <td>
                          <div class="dropdown">
                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                              <i class="bx bx-dots-vertical-rounded"></i>
                            </button>
                            <div class="dropdown-menu">
                              <a class="dropdown-item" href="javascript:void(0);"
                                ><i class="bx bx-edit-alt me-1"></i> Edit</a
                              >
                              <a class="dropdown-item" href="javascript:void(0);"
                                ><i class="bx bx-trash me-1"></i> Delete</a
                              >
                            </div>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td><i class="fab fa-react fa-lg text-info me-3"></i> <strong>003</strong></td>
                        <td>B10</td>
                        <td>25/05/2025
                        </td>
                        <td><span class="badge bg-label-success me-1">FINALIZADO</span></td>
                        <td>
                          <div class="dropdown">
                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                              <i class="bx bx-dots-vertical-rounded"></i>
                            </button>
                            <div class="dropdown-menu">
                              <a class="dropdown-item" href="javascript:void(0);"
                                ><i class="bx bx-edit-alt me-2"></i> Edit</a
                              >
                              <a class="dropdown-item" href="javascript:void(0);"
                                ><i class="bx bx-trash me-2"></i> Delete</a
                              >
                            </div>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td><i class="fab fa-vuejs fa-lg text-success me-3"></i> <strong>002</strong></td>
                        <td>C15</td>
                        <td>15/05/2025
                        </td>
                        <td><span class="badge bg-label-success me-1">FINALIZADO</span></td>
                        <td>
                          <div class="dropdown">
                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                              <i class="bx bx-dots-vertical-rounded"></i>
                            </button>
                            <div class="dropdown-menu">
                              <a class="dropdown-item" href="javascript:void(0);"
                                ><i class="bx bx-edit-alt me-2"></i> Edit</a
                              >
                              <a class="dropdown-item" href="javascript:void(0);"
                                ><i class="bx bx-trash me-2"></i> Delete</a
                              >
                            </div>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <i class="fab fa-bootstrap fa-lg text-primary me-3"></i> <strong>001</strong>
                        </td>
                        <td>C10</td>
                        <td>10/05/2025
                        </td>
                        <td><span class="badge bg-label-warning me-1">CANCELADO</span></td>
                        <td>
                          <div class="dropdown">
                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                              <i class="bx bx-dots-vertical-rounded"></i>
                            </button>
                            <div class="dropdown-menu">
                              <a class="dropdown-item" href="javascript:void(0);"
                                ><i class="bx bx-edit-alt me-2"></i> Edit</a
                              >
                              <a class="dropdown-item" href="javascript:void(0);"
                                ><i class="bx bx-trash me-2"></i> Delete</a
                              >
                            </div>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
              <!--/ Basic Bootstrap Table -->

            </div>
            <!-- / Content -->


<jsp:include page="footer.jsp" />
