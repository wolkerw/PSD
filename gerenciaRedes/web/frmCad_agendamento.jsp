<%@ page pageEncoding="UTF-8" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="com.HC_Lab_agendamento"%>
<html>
<head>
<title></title>
<%@ page import="com.*" errorPage="erro.jsp"%>

<meta HTTP-EQUIV=Expires CONTENT="Thu, 01 Jan 1970 00:00:00 GMT">
<meta HTTP-EQUIV=Cache-Control content=no-store>
<meta HTTP-EQUIV=Pragma content=no-cache>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%!int regCnt;
    int regIndex;
    String strComplemento = "";
    boolean blnErro = false;
    String strErro = "";
    long usuario;%>
<%
    String tela_inicial = "";
    blnErro = false;
    
    Connection conn = null;
    long ultemplog = 0;
    try {
        
        conn = DBSettings.getConexao();
        
        String matricula = request.getParameter("num_matricula") == null?"":request.getParameter("num_matricula").trim();
    	String data_ini = request.getParameter("data_ini") == null?"":request.getParameter("data_ini").trim();
    	String data_fim = request.getParameter("data_fim") == null?"":request.getParameter("data_fim").trim();
    	String hora_ini = request.getParameter("hora_ini") == null?"":request.getParameter("hora_ini").trim();
    	String cod_assunto = request.getParameter("cod_assunto") == null?"":request.getParameter("cod_assunto").trim();
    	String cod_professor = request.getParameter("cod_professor") == null?"":request.getParameter("cod_professor").trim();
        
        HC_Lab_agendamento objAgendamento = new HC_Lab_agendamento();
        objAgendamento.insereAgendamento(Long.parseLong(matricula), 
        							     Long.parseLong(cod_professor), 
        							     Long.parseLong(cod_assunto), 
        							     data_ini, data_fim, Integer.parseInt(hora_ini));
        
                    
       } catch (Exception e){
         	 e.printStackTrace();
             blnErro = true;
             strErro = e.getMessage();
    }
   

    if (!blnErro) {
	              %>
	              <meta http-equiv="refresh" content="0;URL=listapessoa.jsp">
<%
    }else{%>
         		 <%=strErro%>
<%
    }
if(conn != null)
    conn.close();
      %>
</body>
</html>


