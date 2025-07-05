<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Nav -->
<%@page import="javax.servlet.http.HttpSession"%>

<jsp:include page="header.jsp" />
    <!-- Menu -->
        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="app-brand demo">
                <svg width="100px" height="50px">
                     <image href="assets/img/layouts/logo.png" width="50px" height="40px" />
                </svg>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">
            <!-- Dashboard -->
            <li class="menu-item active">
              <a href="index.jsp" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Analytics">Inicio</div>
              </a>
            </li>
            <%
                String rol = (String) session.getAttribute("rol");
            %>


            <!-- Layouts ALUMNO Y PROFESOR-->
            <% if ("alumno".equalsIgnoreCase(rol) || "profesor".equalsIgnoreCase(rol)) { %>
            <!-- Sección Reserva solo para alumno o profesor -->
            <li class="menu-header small text-uppercase">
              <span class="menu-header-text">Sección Reserva</span>
            </li>
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-dock-top"></i>
                <div data-i18n="Account Settings">Reserva</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="seleccionar_parqueo.html" class="menu-link">
                    <div data-i18n="Account">Reservar Estacionamiento</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="VistaReservas.jsp" class="menu-link">
                    <div data-i18n="Account">Mis Reservas</div>
                  </a>
                </li>
              </ul>
            </li>
          <% } %>
          <% if ("admin".equalsIgnoreCase(rol)) { %>
            <li class="menu-header small text-uppercase">
              <span class="menu-header-text"> Gestión</span>
            </li>
           
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-dock-top"></i>
                <div data-i18n="Account Settings"> Gestionar Reservas</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
  <a href="<%= request.getContextPath() %>/listarReservas" class="menu-link">
    <i class="menu-icon tf-icons bx bx-list-ul"></i>
    <div>Listado de Reservas</div>
  </a>
</li>

              </ul>
            </li>
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                    <i class="menu-icon tf-icons bx bx-dock-top"></i>
                    <div data-i18n="Account Settings">Estacionamientos</div>
              </a>
              <ul class="menu-sub">
                    <li class="menu-item">
                      <i class="menu-icon tf-icons bx bx-parking"></i>  
                      <a href="GestionarEstacionamiento_ADM.html" class="menu-link">
                            <div data-i18n="Account">Gestión de Estacionamientos</div>
                      </a>
                    </li>
              </ul>
            </li>
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                    <i class="menu-icon tf-icons bx bx-car"></i>
                    <div data-i18n="Account Settings">Consultas</div>
              </a>
              <ul class="menu-sub">
                    <li class="menu-item">
                      <a href="vehiculo.jsp" class="menu-link">
                            <div data-i18n="Account">Consulta de Placa</div>
                      </a>
                    </li>
              </ul>
            </li>
            <li class="menu-item">
  <a href="javascript:void(0);" class="menu-link menu-toggle">
    <i class="menu-icon tf-icons bx bx-user"></i>
    <div data-i18n="Account Settings">Usuarios</div>
  </a>
  <ul class="menu-sub">
    <li class="menu-item">
      <a href="<%= request.getContextPath() %>/listar" class="menu-link">
        <div data-i18n="Account">Listado de Usuarios</div>
      </a>
    </li>
  </ul>
</li>
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                    <i class="menu-icon tf-icons bx bx-bar-chart-alt-2"></i>
                    <div data-i18n="Account Settings">Reportes</div>
              </a>
              <ul class="menu-sub">
                    <li class="menu-item">
                      <a href="ReportesEstadisticasADM.jsp" class="menu-link">
                            <div data-i18n="Account">Reportes y Estadísticas</div>
                      </a>
                    </li>
              </ul>
            </li>
            <% } %>
          </ul>
        </aside>
        <!-- / Menu -->
        <!-- Layout container -->
        <div class="layout-page">
          <!-- Navbar -->
           <nav
            class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
            id="layout-navbar"
          >
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
              <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
              </a>
            </div>

            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
              <!-- /Search -->
              <ul class="navbar-nav flex-row align-items-center ms-auto">
                <!-- Place this tag where you want the button to render. -->
                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                      <img src="assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                    </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <a class="dropdown-item" href="#">
                          <div class="d-flex">
                            <div class="flex-shrink-0 me-3">
                              <div class="avatar avatar-online">
                                <img src="assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                              </div>
                            </div>
                            <div class="flex-grow-1">
                              <span class="fw-semibold d-block"><%= session.getAttribute("usuario") %></span>
                              <small class="text-muted d-block"><%= session.getAttribute("correo") %></small>
                              <small class="text-muted d-block"><%= session.getAttribute("rol") %></small>
                              <small class="text-muted d-block">ID: <%= session.getAttribute("idUsuario") %></small>
                            </div>
                          </div>
                        </a>
                      </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#">
                        <i class="bx bx-user me-2"></i>
                        <span class="align-middle">Mi Perfil</span>
                      </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="LogoutServlet">
                            <i class="bx bx-power-off me-2"></i>
                            <span class="align-middle">Cerrar Sesión</span>
                        </a>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
          </nav>

          <!-- / Navbar -->
<!-- 
<%
Integer id = (Integer) session.getAttribute("idUsuario");
if (id != null && id == 1) {
    // Mostrar contenido especial para el usuario con ID 1
}
%>
<a href="perfil.jsp?id=<%= session.getAttribute("idUsuario") %>">Ver mi perfil</a>

-->
