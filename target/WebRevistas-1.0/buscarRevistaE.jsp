<%-- 
    Document   : buscarRevistaE
    Created on : 8/10/2019, 10:05:21 AM
    Author     : asael
--%>

<%@page import="com.ashdz.webrevistas.DAO.Etiqueta.EtiquetaDAOImpl"%>
<%@page import="com.ashdz.webrevistas.DAO.Etiqueta.EtiquetaDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="bootstrap.html" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WebRevistas - ${sessionScope.usuario.usuarioSistema}</title>
    </head>
    <body>
        <%@include file="scripts.html" %>
        
        <!--Barra de navegacion-->
        <%@include file="navBarSuscriptor.html"%><br><br><br>
        <h5>Buscar Revista</h5>


        <!--Buscar Revista por etiquetas-->
        <%
            EtiquetaDAO etiqDAO = EtiquetaDAOImpl.getEtiquetaDAO();
            ResultSet rs = etiqDAO.getResultSetEtiqueta();

        %><form action="BuscarRevistaEController" method="POST">&nbsp&nbsp&nbsp&nbsp
            <%while (rs.next()) {
            %><div class="form-check form-check-inline">
                <input class="form-check-input" type="checkbox" name="etiquetas" value="<%=rs.getString("IdEtiqueta")%>">
                <label class="form-check-label" for="inlineCheckbox1"><%=rs.getString("NombreEtiqueta")%></label>
            </div><%
                }
            %><c:if test="${requestScope['errorNull'] != null}">
                <br>&nbsp&nbsp&nbsp&nbsp<small  class="text-danger">No se ha seleccionado ninguna etiqueta.</small>
            </c:if>
            <div class="col">
                <button type="submit" class="btn btn-primary">Buscar</button>
            </div>
        </form><br>

        <!--Tabla de revistas-->
        <h5>Lista de Revistas</h5>
        <%
            String sql;
            ResultSet rs2 = null;
            if (request.getAttribute("sql") != null) {
                sql = request.getAttribute("sql").toString();
                rs2 = etiqDAO.getResultSetRev(sql);
            }
        %>

        <form action="Previsualizar" method="POST">
            <table class="table w-75 p-3">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Editor</th>
                        <th scope="col">Precio</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            while (rs2.next()) {
                    %><tr>
                        <th scope="row"><%=rs2.getString(1)%></th>
                        <td><%=rs2.getString(2)%></td>
                        <td><%=rs2.getString(3)%></td>
                        <td><%=rs2.getString(4)%></td>
                        <td><button type="submit" class="btn btn-outline-info" name="id" value="<%=rs2.getString(1)%>">Previsualizar</button></td>
                    </tr><%
                            }
                        } catch (Exception e) {
                            System.out.println(e.getMessage());
                        }
                    %>

                </tbody>
            </table>
        </form>
                    
        <c:if test="${requestScope['rev'] != null}">
            <script type="text/javascript">
                $(document).ready(function () {
                    $('#preview').modal();
                });
            </script>
            ${rev.nombreRevista}
        </c:if>
        <!-- Modal -->
        <div class="modal fade" id="preview" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalScrollableTitle">${rev.nombreRevista}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>