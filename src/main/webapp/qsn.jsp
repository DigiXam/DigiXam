<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="UTF-8"%>
<%@page import= "java.sql.*,com.IMAP.DAO.*"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.*"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>

<%!
   String role;
   String sql;
   String user;
   String sp="super-admin";
   String ad="admin";
   String te="teacher";
%>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{	
		String sql2="SELECT role, name FROM users where email = ? OR username = ?";
		try{
		DbConnection dbcon2 = new DbConnection();
		Connection con2 = dbcon2.getConnection();
		PreparedStatement st2= con2.prepareStatement(sql2);
		st2.setString(1, (String)session.getAttribute("email"));
		st2.setString(2, (String)session.getAttribute("username"));
		ResultSet rs2= st2.executeQuery();
		if(rs2.next())
		{
			role = rs2.getString("role");
			user = rs2.getString("name");
		}
		rs2.close();
   		st2.close();
   		con2.close();
   		}catch(Exception e){
   			e.printStackTrace();
   		}
		

		String encArray = request.getParameter("file");
		String decArray = URLDecoder.decode(encArray,"utf-8");
		String [] file = decArray.split(",");
%>
<jsp:include page="header.jsp"></jsp:include>
<!-- CSS for Navbar & Sidebar -->
<style>
/* Googlefont Poppins CDN Link */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
.sidebar-dark-primary{
          background-color: #ec2829;
}

</style>
<div class="wrapper">
<jsp:include page="dashboard_navbar.jsp"></jsp:include>
<jsp:include page="dashboard_sidebar.jsp"></jsp:include>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
<section class="content-header ">
  <div class="container-fluid">
    <div class="row mb-2">
      <!-- <div class="col-sm-6">
        <h1>Users</h1>
      </div> -->
      <div class="col-sm-6 offset-sm-6">
      
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item"><a href="#"><%=role %></a></li>
          <li class="breadcrumb-item active"><%=user %></li>
        </ol>
      </div>
    </div>
  </div><!-- /.container-fluid -->
</section>
<!-- Main content -->

<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
		
		<div class="card text-center">
		  <div class="card-header">
		    <%=new DatabaseDAO().getSubjectName(Integer.parseInt((String)session.getAttribute("id"))).toUpperCase()%>
		  </div>
		  <div class="card-body">
		<%for(String f :file) {%>
		  	<img src="doc/<%=f.trim()%>" class="card-img-top" alt="...">
		  	<hr>
		 <%} %> 
		  </div>
		  <div class="card-footer text-muted">
		    2 days ago
		  </div>
		</div>

      </div>
      <!-- /.col -->
    </div>
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</section>
<!-- /.content -->

</div>
<!-- /.content-wrapper -->
<footer class="main-footer">
  <div class="float-right d-none d-sm-block">
    <b>Version</b> 3.2.0
  </div>
  <strong>Copyright &copy; 2021-<%
      GregorianCalendar cal = new GregorianCalendar();
      out.print(cal.get(Calendar.YEAR));
    %> <a href="<%=request.getContextPath()%>/login">DigiXam</a>.</strong> All rights reserved.
</footer>
</div>
<jsp:include page="footer.jsp"></jsp:include>

 </body>
</html>
<%}%>