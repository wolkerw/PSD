<%@page import="java.util.Date"%>
<%@page import="com.HC_Lab_assuntos"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.HC_Lab_agendamento"%>
<%@page import="com.DBSettings"%>
<%@page import="com.HC_Lab_pessoa"%>
<%@ page pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%//codeGenVersion 2.0.72


Connection conn = DBSettings.getConexao();
if(session.getAttribute("usuario")!=null){
	
	
	HC_Lab_agendamento lab = new HC_Lab_agendamento();
	lab.setInTransaction(true);
	lab.setConnexao(conn);
	lab.setOrderBy("data_ini desc");
	lab.setJoin(
	" FROM lab_agendamento "  +
    "	LEFT join lab_pessoa " +  
    "	  ON lab_agendamento.cod_aluno = lab_pessoa.cod_pessoa " + 
    "	LEFT join lab_assuntos   " +
    "	  ON lab_agendamento.cod_assunto = lab_assuntos.cod_assunto "); 
	
	String matricula = request.getParameter("num_matricula") == null?"":request.getParameter("num_matricula").trim();
	String data_fim = request.getParameter("data_fim") == null?"":request.getParameter("data_fim").trim();
	String data_ini = request.getParameter("data_ini") == null?"":request.getParameter("data_ini").trim();
	String cod_assunto = request.getParameter("cod_assunto") == null?"":request.getParameter("cod_assunto").trim();
	String okcancelado = request.getParameter("okcancelado") == null?"":request.getParameter("okcancelado").trim();
	
	if(!cod_assunto.equalsIgnoreCase("")){
		lab.setCodassunto(Integer.parseInt(cod_assunto));
	}
	
	lab.setFiltroIntervalo("1=1");
	Date dtIni = null;
	Date dtFim = null;
	boolean errodata = false;
	try{
			dtIni = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").parse(data_ini+" 00:00:00");
	}catch(Exception e){
		errodata = true;
	}
	try{
			dtFim = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").parse(data_fim+" 23:59:59");
	}catch(Exception e){
		errodata = true;
	}
	
	if(okcancelado.equalsIgnoreCase("")){
		
	}else if(okcancelado.equalsIgnoreCase("O")){
		lab.setFiltroIntervalo(lab.getFiltroIntervalo() + " and Coalesce(flag_staus,'O') = 'O' ");		
	} else if(okcancelado.equalsIgnoreCase("C")){
		lab.setFiltroIntervalo(lab.getFiltroIntervalo() + " and flag_staus = 'C' ");
	}

	
	if(!errodata)
		lab.setFiltroIntervalo(lab.getFiltroIntervalo() + "  AND Lab_agendamento.data_ini BETWEEN '"+ new SimpleDateFormat("yyyyMMdd HH:mm:ss").format(dtIni) +"' AND '"+ new SimpleDateFormat("yyyyMMdd HH:mm:ss").format(dtFim) +"' ");
	
	if(!matricula.equalsIgnoreCase("")){
		lab.setFiltroIntervalo(lab.getFiltroIntervalo() + " and lab_pessoa.num_matricula = " +  matricula );
	}
	
	if(session.getAttribute("tipo").toString().equalsIgnoreCase("AL")){
		lab.setCodaluno(Long.parseLong(session.getAttribute("usuario").toString()));
	};
	
	lab.lista();
	
	
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.Connection"%>
<html>

<style>

	.radius {
		-moz-border-radius: 6px;
		-webkit-border-radius: 6px;
		border-radius: 6px;
	}
	
	
	.glowing-border {
		border: 2px solid #dadada;
		border-radius: 7px;
	}
	
	.glowing-border:focus {
		outline: none;
		border-color: #9ecaed;
		box-shadow: 0 0 10px #9ecaed;
	}
</style>


    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista agendamentos</title>

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
        
        <script>
        
$(document).ready(function() {
	
	$("#filtrar").button().click(function(){
		var form = document.getElementById('forme');
		form.action="lista_agendamentos.jsp";
		form.submit();
	});
	
	$( ".data" ).datepicker();
	$(".ui-datepicker-trigger").css('position', 'relative');
	$(".ui-datepicker-trigger").css('top', '3px');
	$(".ui-datepicker-trigger").css('left', '1px');
	$(".data").mask("99/99/9999");
    
	$(".sys_remove").button().click(function(){
		$.blockUI({ message: 'Cancelado agendamento...' });
			cancelaAgendamento($(this).attr("seqagend"));
	 	$.unblockUI();
		return false;
		
	});
	
});


function cancelaAgendamento(seqagend){


	
	$.ajax({
	      type: "POST",                                                                                          
	      url: "lista_agendamentos_ajax.jsp",
	      dataType: "json",         
	      async: true, 
	      data: { cmd: 'cancelar',seqagend:seqagend
	      },
	      success:function (data) {
	    	  
	    	  if(data.msg!=undefined){
	    		 	 alert( "Erro: " + data.msg );
	    		 	 
		      }else{
					  alert('Agendamento cancelado!');
					  location.reload(true); 
		      }
	    	  
	      $.unblockUI();
	      },
	      error: function(msg){
	    	$.unblockUI();
	        alert( "Erro: " + msg.msg );
	      }
	   }); 
	
	
} 

function isNumberKey(evt)
{
   var charCode = (evt.which) ? evt.which : event.keyCode
   if (charCode > 31 && (charCode < 48 || charCode > 57))
      return false;

   return true;
}
</script>
        
        
    </head>
    <form id="forme" action="post">
    <body>
        <br>     
        <div style="width: 85%" class="container bs-docs-container">
            
            <div class="row">
		         
		         	<%if(!session.getAttribute("tipo").toString().equalsIgnoreCase("AL")){%>
		           <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">  
		           
		       				   <strong>Matricula:</strong><br> &nbsp;<input class="glowing-border" style="WIDTH: 80%"   onkeypress="return isNumberKey(event)"  id="num_matricula" name="num_matricula" type="text" maxlength="100">
		           
		           </div>
		           <% }%>
		           <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">
		                     
		           		   	  <strong>Assunto:</strong><br> &nbsp;
		           		   	  <%HC_Lab_assuntos assuntos = new HC_Lab_assuntos();
		           		   	   assuntos.setConnexao(conn);
		           		   	   assuntos.setInTransaction(true);
		           		   	   assuntos.setOrderBy("desc_assunto");
		           		   	   assuntos.lista();
		           		   	  %>
		           		   	  
		           		   	  <select class="glowing-border" style="WIDTH: 80%" id="cod_assunto" name="cod_assunto" type="text" maxlength="100" >  
		           		   	  <option value=""> Todos</option>
		           		   	  <%while(assuntos.next()){%>
		           		   		  <option value="<%=assuntos.getRsCodassunto()%>" >  <%=assuntos.getRsDescassunto() %></option>
		           		   	  <% }%>
		           		   	  </select>
		           		   	  
		           </div>
		           
		           
		               <div class="col-xs-3col-sm-3 col-md-3 col-lg-3">  
		           
		       				   <strong >OK/Cancelado:</strong><br>
		       				    <select style="width: 80%" id="okcancelado" name="okcancelado"" class="glowing-border" >
		       				    <option value="">Ambos</option>
		       				    <option value="O">Ok</option>
		       				    <option value="C">Cancelado</option>
		       				    </select>
		           
		           </div>
		         
		     </div> 
		   <div class="row">  
		           <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">                
		           		   	  <strong>Período - Data inicial :</strong><br> &nbsp;<input class="data glowing-border" style="WIDTH: 80%" id="data_ini" name="data_ini" type="text" maxlength="100">
		           </div>
            
           		 	<div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">                
		           		   	  <strong>Período - Data final :</strong><br> &nbsp;<input class="data glowing-border" style="WIDTH: 80%" id="data_fim" name="data_fim" type="text" maxlength="100">
		           </div>
            
            
              <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">       
              <br>         
		           		   	 <button class="btn btn-primary" id="filtrar">Filtrar</button>
		           </div>
            </div>
            
             <div class="row">  
		         
           		 	
            
            </div>
            
            <br>
            <div class="row">
                <div id="divTab" class="bs-example"  style="height: 750px;  overflow-y: scroll;">
                    <table id="maquinasTab" class="table  header-fixed  table-striped table-bordered table-hover ">
                       <thead class="header">
                            <tr>
                                <th style="text-align: center; width: 25%">Aluno</th>
                                <th style="text-align: center; width: 25%">Professor</th>
                                <th style="text-align: center; width: 35%">Assunto</th>
                                <th style="text-align: center; width: 15%">Data</th>
                                <th style="text-align: center; width: 15%">Status</th>
                                <th style="text-align: center; width: 15%"></th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        while(lab.next()){
                        	String status ="";
                        	if(lab.getRsFlagstaus()==null){
                        		status = "Ok";
                        	}
                        	else if(lab.getRsFlagstaus().equalsIgnoreCase("C")){
                        		status = "Cancelado";
                        	}else if(lab.getRsFlagstaus().equalsIgnoreCase("O")){
                        		status = "Ok";
                        	}
                        
                        %>
                        	<tr>
								<td style="text-align: center; width: 25%" ><%=lab.getObCodaluno().getRsNummatricula() + " - " + lab.getObCodaluno().getRsDescnome()%></td>
								<td style="text-align: center; width: 25%" ><%=lab.getObCodprofessor().getRsDescnome()%></td>
								<td style="text-align: center; width: 25%" ><%=lab.getObCodassunto().getRsDescassunto()%></td>
								<td style="text-align: center; width: 25%" ><%=new SimpleDateFormat("dd/MM/yyyy HH:mm").format(lab.getRsDataini())%></td>
								<td style="text-align: center; width: 25%" ><%=status%></td>
								<th style="text-align: center; width: 15%">
								<%if(status.equalsIgnoreCase("ok")){ %> 
									<button seqagend="<%=lab.getRsSeqagendametno()%>" class="sys_remove btn btn-primary" " >Cancelar</button> 
								<%}%>
								</th>
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
</body>
</form>
        
</html>
<%}else{%>
	
	Você não está logado
	
	
<%} %>
