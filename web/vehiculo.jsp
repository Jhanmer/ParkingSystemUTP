<jsp:include page="nav.jsp" />
<%@ page import="org.json.JSONObject" %>
<div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Vehículo/</span> Registro vehiculo</h4>

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
                              <h2>Consulta de Placa</h2>

                              <% String error = (String) request.getAttribute("error"); %>
                              <% if (error != null) { %>
                                <p style="color:red;"><%= error %></p>
                              <% } %>

                              <form method="post" action="consultaPlaca">
                                <div class="form-row">
                                  <label class="form-label" for="placa">Número de placa:</label>
                                  <input class="form-control" type="text" id="placa" name="placa" required maxlength="6" />
                                  <br>
                                  <input type="submit" value="? Buscar" class="btn btn-primary" />
                                </div>
                              </form>
                                  <% JSONObject data = (JSONObject) request.getAttribute("data"); %>
                                  <% if (data != null) { %>
                                      <div>
                                        <div class="mb-3">
                                          <label class="form-label">Marca:</label>
                                          <input type="text" class="form-control" value="<%= data.optString("marca") %>" readonly />
                                        </div>
                                        <div class="mb-3">
                                          <label class="form-label">Modelo:</label>
                                          <input type="text" class="form-control" value="<%= data.optString("modelo") %>" readonly />
                                        </div>
                                        <div class="mb-3">
                                          <label class="form-label">Serie:</label>
                                          <input type="text" class="form-control" value="<%= data.optString("serie") %>" readonly />
                                        </div>
                                        <div class="mb-3">
                                          <label class="form-label">Color:</label>
                                          <input type="text" class="form-control" value="<%= data.optString("color") %>" readonly />
                                        </div>
                                        <div class="mb-3">
                                          <label class="form-label">Motor:</label>
                                          <input type="text" class="form-control" value="<%= data.optString("motor") %>" readonly />
                                        </div>
                                        <div class="mb-3">
                                          <label class="form-label">VIN:</label>
                                          <input type="text" class="form-control" value="<%= data.optString("vin") %>" readonly />
                                        </div>
                                      </div>
                                    <% } %>
                            </div>
                          </div>
                        </div>
                      </div>
                  </div>
                </div>
              </div>
            </div>
<!-- Footer -->           
<jsp:include page="footer.jsp" />