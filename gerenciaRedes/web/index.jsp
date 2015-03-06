<%@page  contentType="text/html; charset=UTF-8"%>
<%@ page
	import="com.*,java.text.*,java.util.*,java.sql.*,java.io.*,java.lang.*"
	errorPage="erro.jsp"%>
<jsp:useBean id="oUt" scope="session" class="com.Utilitario" />
<HTML>
<HEAD>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="stl_padrao.css" rel="stylesheet" type="text/css">
<meta http-equiv="Pragma" content="no-cache">
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF
}
-->
</style>
<%
	session.invalidate();
	String strLogo = "logo_teste.jpg";
	if (new File(application.getRealPath("/img/logo_teste.jpg"))
			.exists()) {
		strLogo = "logo_teste.jpg";
	}
%>
</head>
</HEAD>
<BODY>
	<form name="form" method="post" action="">
		<TABLE align="center" cellSpacing=0 cellPadding=0 width="35%" border=0>
			<TR>
				<TD align="center">
					<P>&nbsp;</P>
					<P>&nbsp;</P>
					<P>
						<img src="img/<%=strLogo%>"></img>
					</P>
					<P>&nbsp;</P>
					<P class="clsFontes">
						<font size="4" color="#003399"><strong></strong>
						</font>
					</P>
					<P>&nbsp;</P></TD>
			</TR>
			<TR>
				<TD align="middle" class="clsFontes"><legend>
						<font size=2 color="#0000CC"><strong>Login<br>&nbsp;</strong>
						</font>
					</legend>
					<table border="0" cellpadding="0" cellspacing="0" width="310">
						<tr>
							<td><STRONG><FONT size="2"><span
										class="clsFontes">Usuário:</span>&nbsp;
							</td>
							<td><INPUT id=txtLG_USUARIO name=txtLG_USUARIO size=30
								class="clsCampos"></FONT></STRONG>
							</td>
						</tr>
						<tr>
							<td><STRONG><FONT size=2><span
										class="clsFontes">Senha:</span>
							</td>
							<td><INPUT id=txtVL_SENHA type=password name=txtVL_SENHA
								width="100%" size=30 class="clsCampos"
								onKeypress="if (event.keyCode==13) {  form.action='frmUsuario_login.jsp'; form.submit();}">
								</FONT></STRONG>
							</td>
						</tr>

						<tr>
							<td colspan="100%" align="center"><input name="Button2"
								type="button" class="clsCampos" value="Logar"
								OnClick="form.action='frmUsuario_login.jsp'; form.submit();">
								<input name="Reset2" type="reset" class="clsCampos" id="Reset2"
								value="Limpar">
							</td>
						</tr>
					</table></TD>
			</TR>
			<TR>
				<TD></TD>
			</TR>
		</TABLE>
	</form>
</BODY>
<script language="JScript">
	document.form['txtLG_USUARIO'].focus();
</script>
</HTML>