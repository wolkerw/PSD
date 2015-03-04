<%@page import="com.DBSettings"%>
<%@page import="com.HC_Lab_pessoa"%>
<%@ page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%//codeGenVersion 2.0.72%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.Connection"%>
<html>     
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Lista pessoas</title>

        <script type="text/javascript" src="JavaScript/jquery-ui-1.10.4.custom/js/jquery-1.10.2.js"></script>
        <script type="text/javascript" src="JavaScript/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.js"></script>
        <script type="text/javascript" src="JavaScript/jquery-ui-1.10.4.custom/js/autoNumeric.1.9.22.js" charset="utf-8"></script>
        <script type="text/javascript" src="JavaScript/jquery-ui-1.10.4.custom/js/jquery.mask.min.js"></script>
        <script type="text/javascript" src="JavaScript/jquery-ui-1.10.4.custom/js/jquery.blockUI.js"></script>  
        <script type="text/javascript" src="JavaScript/jquery-ui-1.10.4.custom/js/jquerydatepicker-ptbr.js"></script>
        <script type="text/javascript" src="JavaScript/jquery-ui-1.10.4.custom/js/jquery.dataTables.js" charset="utf-8" language="javascript"></script>
        <link rel="stylesheet" type="text/css" href="JavaScript/jquery-ui-1.10.4.custom/css/ui-blitz/jquery-ui.css" />
        <link rel="stylesheet" type="text/css" href="JavaScript/jquery-ui-1.10.4.custom/css/jquery.dataTables.css" />
        <script type="text/javascript" src="JavaScript/bootbox.min.js"></script>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="JavaScript/bootstrap-3.2.0-dist/css/bootstrap.min.css">
        <!-- Optional theme -->
        <link rel="stylesheet" href="JavaScript/bootstrap-3.2.0-dist/css/bootstrap-theme.min.css">
        <!-- Latest compiled and minified JavaScript -->
        <script src="JavaScript/bootstrap-3.2.0-dist/js/bootstrap.min.js"></script>
        <script src="JavaScript/jquery.modern-blink.js"></script>
    </head>
    <body>
        <br>     
        <div class="container bs-docs-container">
            <div class="row">
                <div id="divTab" class="bs-example"  style="height: 400px;  overflow-y: scroll;">
                    <table id="maquinasTab" class="table table-bordered table-hover table-condensed">
                        <thead>
                            <tr>
                                <th style="text-align: center; width: 5%">Cód</th>
                                <th style="text-align: center; width: 20%">nome</th>
                                <th style="text-align: center; width: 10%">Matricula</th>
                                <th style="text-align: center; width: 20%">curso</th>
                                <th style="text-align: center; width: 10%">Num telefone</th>
                                <th style="text-align: center; width: 15%">Email</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        Connection conn = DBSettings.getConexao();
                        HC_Lab_pessoa lab_pessoa = new HC_Lab_pessoa(); 
                        lab_pessoa.setConnexao(conn);
                        lab_pessoa.setInTransaction(true);
                        lab_pessoa.lista();
                        
                        while(lab_pessoa.next()){%>
                        	<tr>
								<td><%=lab_pessoa.getRsCodpessoa()%></td>
								<td><%=lab_pessoa.getRsDescnome()%></td>
								<td><%=lab_pessoa.getRsNummatricula()%></td>
								<td><%=lab_pessoa.getObCodcurso().getRsDesccurso()%></td>
								<td><%=lab_pessoa.getRsNumtelefone()%></td>
								<td><%=lab_pessoa.getRsDescemail()%></td>
								                        	
                        	</tr>

                        <%}
                        conn.close();
                        %>
                        
                            <tr class="active">
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        
        
</html>
