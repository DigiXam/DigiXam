<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*,com.IMAP.DAO.DbConnection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="com.google.gson.Gson"%>

<%!
   String role;
   String sql,sql4,sql3;
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
<section class="content-header">
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
      <%if(role.equals("admin")||role.equals("super-admin")){ %>
     	<div class="card">
          <div class="card-header">
            <h3 class="card-title mt-2 font-weight-bold">Examination</h3>
            
             <a class="btn btn-outline-primary float-right" data-toggle="modal" data-target="#addmodal">
              <span class="fa fa-plus mr-1" aria-hidden="true"></span> <span> Add</span>
             </a>
            	 <!-- Modal -->
			    <div class="modal fade" id="addmodal" tabindex="-1" role="dialog" aria-labelledby="addmodalTitle1" aria-hidden="true">
			      <div class="modal-dialog modal-dialog-centered" role="document">
			        <div class="modal-content">
			        	  <form action="ExaminationController" method="post" enctype="multipart/form-data">
					        <div class="modal-header">
					          <h5 class="modal-title" id="exampleModalCenterTitle">Subject</h5>
					          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					          </button>
					        </div>
					        <div class="modal-body">
					        <%
				
							sql="SELECT * FROM subjects order by id desc";
							
							//out.println(sql);
							try{
							DbConnection dbcon2 = new DbConnection();
							Connection con2 = dbcon2.getConnection();
							PreparedStatement st2= con2.prepareStatement(sql);
							ResultSet rs2= st2.executeQuery();
						  	//int i=1;
						  	if(rs2.isBeforeFirst()){
						  		out.println(" ");
						  	}
						  		
						  %>
		                      
						  <div class="form-group row">
		                  <label for="staticEmail" class="col-sm-2 col-form-label">Subjects</label>
		                  <div class="col-sm-10">
		            		<select class="form-control" name="sub">
		                      	<%while(rs2.next())		
								{	
		                      	%>
		                          <option value="<%=rs2.getInt("id")%>"><%=rs2.getString("name")%></option>
		                          
		                       <%} %>
		                      </select>		
		                  </div>
		                  </div>
		                  <%
							  	rs2.close();
								st2.close();
								con2.close();
								}catch(Exception e){
										e.printStackTrace();
								}
							%>
		               <!-- /.subjects -->
					           
					      <%
					
					      sql="SELECT * FROM department order by id desc";
					      
					      //out.println(sql);
					      try{
					      DbConnection dbcon3 = new DbConnection();
					      Connection con3 = dbcon3.getConnection();
					      PreparedStatement st3= con3.prepareStatement(sql);
					      ResultSet rs3= st3.executeQuery();
					        //int i=1;
					        if(rs3.isBeforeFirst()){
					          out.println(" ");
					        }
					          
					      %>
					                  
					      <div class="form-group row">
					              <label for="staticEmail" class="col-sm-2 col-form-label">Departments</label>
					              <div class="col-sm-10">
					            <select class="form-control" name="dept">
					                    <%while(rs3.next())		
					        {	
					                    %>
					                      <option value="<%=rs3.getInt("id")%>"><%=rs3.getString("name")%></option>
					                      
					                   <%} %>
					                  </select>		
					              </div>
					              </div>
					              <%
					          rs3.close();
					        st3.close();
					        con3.close();
					        }catch(Exception e){
					            e.printStackTrace();
					        }
					      %>
					      <!-- /.department -->
					      <%
					
					      sql="SELECT * FROM users where role=? order by id desc";
					      
					      //out.println(sql);
					      try{
					      DbConnection dbcon4 = new DbConnection();
					      Connection con4 = dbcon4.getConnection();
					      PreparedStatement st4= con4.prepareStatement(sql);
					      st4.setString(1, "teacher");
					      ResultSet rs4= st4.executeQuery();
					        //int i=1;
					        if(rs4.isBeforeFirst()){
					          out.println(" ");
					        }
					          
					      %>
					                  
					      <div class="form-group row">
					              <label for="staticEmail" class="col-sm-2 col-form-label">Teachers</label>
					              <div class="col-sm-10">
					            <select class="form-control" name="user">
					                    <%while(rs4.next())		
					        {	
					                    %>
					                      <option value="<%=rs4.getInt("id")%>"><%=rs4.getString("email")%></option>
					                      
					                   <%} %>
					                  </select>		
					              </div>
					              </div>
					              <%
					          rs4.close();
					        st4.close();
					        con4.close();
					        }catch(Exception e){
					            e.printStackTrace();
					        }
					      %>
					      <!-- /.user -->	  
					      <input type="file" name="qsn">
					        </div>
					        <div class="modal-footer">
					          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					          <!--<button type="button" class="btn btn-primary">Save changes</button>  -->
					        <input type="submit" class="btn btn-info" value="Update">
					        </div>
					   </form>
			        </div>
			      </div>
			    </div>
            	<!-- /.modal -->
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <table id="example1" class="table table-bordered ">
              <thead>
              <tr>
                  <th>Sl No.</th>
			      <th>Teacher</th>
			      <th>Email ID</th>
			      <th>Department</th>
			      <th>Subject</th>
			      <th>File</th>
			      <th>Action</th>
              </tr>
              </thead>
              <tbody>
              <%
              sql="select * from examination as e inner join subjects as s on e.sub_id=s.id inner join department as d on e.dept_id=d.id inner join users u on e.user_id=u.id order by e.id desc";
              
				//out.println(sql);
				try{
				DbConnection dbcon = new DbConnection();
				Connection con = dbcon.getConnection();
				PreparedStatement st= con.prepareStatement(sql);
				ResultSet rs= st.executeQuery();
			  	int i=1;
			  	if(!rs.isBeforeFirst()){
			  		out.println(" ");
			  	}
			  	while(rs.next())		
				{		
			  %>
			    <tr>
			      <td><%=rs.getInt("e.id")%></td>
			      <td><%=rs.getString("u.name")%></td>
			      <td><%=rs.getString("u.email")%></td>
			      <td><%=rs.getString("d.name")%></td>
			      <td><%=rs.getString("s.name")%></td>
			      <td class="text-truncate"><%= new Gson().fromJson(rs.getString("e.qsn_name"), String[].class)[0].split("_1")[0].concat(".png")%></td>
			      <td>
			      <!-- Button trigger modal -->
					<a class="actionCust" data-toggle="modal" data-target="#exampleModalCenter<%=rs.getInt("e.id")%>" style="cursor:pointer;">
					  <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
					</a>
					<!-- Modal -->
					<div class="modal fade" id="exampleModalCenter<%=rs.getInt("e.id")%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle<%=rs.getInt("e.id")%>" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					     <%
					     String sql1="select * from examination as e inner join subjects as s on e.sub_id=s.id inner join department as d on e.dept_id=d.id inner join users u on e.user_id=u.id where e.id=?;";
					      
						  	try{
						  	DbConnection dbcon1 = new DbConnection();
						  	Connection con1 = dbcon1.getConnection();
						  	PreparedStatement st1= con1.prepareStatement(sql1);
						  	st1.setInt(1, rs.getInt("e.id"));
						  	ResultSet rs1= st1.executeQuery();
					      	if(rs1.next())
					      	{  		
					    %>
					     <form action="EditExaminationController" method="post" enctype="multipart/form-data">
					        <div class="modal-header">
					          <h5 class="modal-title" id="exampleModalCenterTitle">Examination</h5>
					          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					          </button>
					        </div>
					        <div class="modal-body">
					        
					            
					         <%
				
							sql2="SELECT * FROM subjects order by id desc";
							
							//out.println(sql);
							try{
							DbConnection dbcon2 = new DbConnection();
							Connection con2 = dbcon2.getConnection();
							PreparedStatement st2= con2.prepareStatement(sql2);
							ResultSet rs2= st2.executeQuery();
						  	//int i=1;
						  	if(rs2.isBeforeFirst()){
						  		out.println(" ");
						  	}
						  		
						  %>
		                      
						  <div class="form-group row">
		                  <label for="staticEmail" class="col-sm-2 col-form-label">Subjects</label>
		                  <div class="col-sm-10">
		            		<select class="form-control" name="sub">
		                      	<%while(rs2.next())		
								{	
		                      	%>
		                          <option value="<%=rs2.getInt("id")%>"><%=rs2.getString("name")%></option>
		                          
		                       <%} %>
		                      </select>		
		                  </div>
		                  </div>
		                  <%
							  	rs2.close();
								st2.close();
								con2.close();
								}catch(Exception e){
										e.printStackTrace();
								}
							%>
		               <!-- /.subjects -->
					           <%
					
					      sql3="SELECT * FROM department order by id desc";
					      
					      //out.println(sql);
					      try{
					      DbConnection dbcon3 = new DbConnection();
					      Connection con3 = dbcon3.getConnection();
					      PreparedStatement st3= con3.prepareStatement(sql3);
					      ResultSet rs3= st3.executeQuery();
					        //int i=1;
					        if(rs3.isBeforeFirst()){
					          out.println(" ");
					        }
					          
					      %>
					                  
					      <div class="form-group row">
					              <label for="staticEmail" class="col-sm-2 col-form-label">Departments</label>
					              <div class="col-sm-10">
					            <select class="form-control" name="dept">
					                    <%while(rs3.next())		
					        {	
					                    %>
					                      <option value="<%=rs3.getInt("id")%>"><%=rs3.getString("name")%></option>
					                      
					                   <%} %>
					                  </select>		
					              </div>
					              </div>
					              <%
					          rs3.close();
					        st3.close();
					        con3.close();
					        }catch(Exception e){
					            e.printStackTrace();
					        }
					      %>
					      <!-- /.department -->
					      <%
					
					      sql4="SELECT * FROM users where role=? order by id desc";
					      
					      //out.println(sql);
					      try{
					      DbConnection dbcon4 = new DbConnection();
					      Connection con4 = dbcon4.getConnection();
					      PreparedStatement st4= con4.prepareStatement(sql4);
					      st4.setString(1, "teacher");
					      ResultSet rs4= st4.executeQuery();
					        //int i=1;
					        if(rs4.isBeforeFirst()){
					          out.println(" ");
					        }
					          
					      %>
					                  
					      <div class="form-group row">
					              <label for="staticEmail" class="col-sm-2 col-form-label">Teachers</label>
					              <div class="col-sm-10">
					            <select class="form-control" name="user">
					                    <%while(rs4.next())		
					        			{	
					                    %>
					                      <option value="<%=rs4.getInt("id")%>"><%=rs4.getString("email")%></option>
					                      
					                   <%} %>
					                  </select>		
					              </div>
					              </div>
					              <%
					          rs4.close();
					        st4.close();
					        con4.close();
					        }catch(Exception e){
					            e.printStackTrace();
					        }
					      %>
					      <!-- /.user -->	  
					      <input type="file" name="qsn">
					      <input type="hidden" name="id" value='<%=rs.getInt("id")%>'>
					        </div>
					        <div class="modal-footer">
					          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					          <!--<button type="button" class="btn btn-primary">Save changes</button>  -->
					        <input type="submit" class="btn btn-info" value="Update">
					        </div>
					        </form>
						<%}%>
					    </div>
					  </div>
					</div>
				<%
					rs1.close();
			   		st1.close();
			   		con1.close();
			   		}catch(Exception e){
			   			e.printStackTrace();
			   		}
				%>  
				
			   		<span class="actionCust ml-3 ">
			   			<a href="<%=request.getContextPath()%>/DeleteExaminationController?id=<%=rs.getInt("e.id")%>" style="cursor:pointer;">
			   				<i class="fa fa-trash-o" aria-hidden="true"></i>
			   			</a>
			   		</span>
			   		<span class="actionCust float-right">
			   			<a href="<%=request.getContextPath()%>/ReadFileController?id=<%=rs.getInt("id")%>" style="cursor:pointer;">
			   				<i class="fa fa-eye" aria-hidden="true"></i>
			   			</a>
			   		</span>
			   		
			     </td>
			    </tr>
			    <%
			  	i++;
			  	}
			  	rs.close();
				st.close();
				con.close();
				}catch(Exception e){
						e.printStackTrace();
					}
				%>
			  </tbody>
            </table>
          </div>
      </div> 
      <%} %>
      
      <%
if(role.equals("teacher")){
sql="SELECT * FROM subjects order by id desc";

//out.println(sql);
try{
DbConnection dbcon = new DbConnection();
Connection con = dbcon.getConnection();
PreparedStatement st= con.prepareStatement(sql);
ResultSet rs= st.executeQuery();
  int i=1;
  if(rs.isBeforeFirst()){
    out.println(" ");
  }
  while(rs.next())		
{		
%>
<div class="accordion" id="accordionExample">
<div class="card">
<div class="card-header" id="headingOne">
  <h2 class="mb-0">
    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
      <%=rs.getString("name") %>
    </button>
  </h2>
</div>

<div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
  <div class="card-body">
  
     <!-- Button trigger modal -->
  <a class="actionCust btn" data-toggle="modal" data-target="#exampleModalCenter<%=rs.getInt("id")%>" style="cursor:pointer;">
    add
  </a>
  <!-- Modal -->
  <div class="modal fade" id="exampleModalCenter<%=rs.getInt("id")%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle<%=rs.getInt("id")%>" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
      <form action="ExaminationController" method="post" enctype="multipart/form-data">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalCenterTitle">Subject</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
        
            <input type="hidden" name="sub" value="<%=rs.getInt("id")%>">
           <%

      sql="SELECT * FROM department order by id desc";
      
      //out.println(sql);
      try{
      DbConnection dbcon3 = new DbConnection();
      Connection con3 = dbcon3.getConnection();
      PreparedStatement st3= con3.prepareStatement(sql);
      ResultSet rs3= st3.executeQuery();
        //int i=1;
        if(rs3.isBeforeFirst()){
          out.println(" ");
        }
          
      %>
                  
      <div class="form-group row">
              <label for="staticEmail" class="col-sm-2 col-form-label">Departments</label>
              <div class="col-sm-10">
            <select class="form-control" name="dept">
                    <%while(rs3.next())		
        {	
                    %>
                      <option value="<%=rs3.getInt("id")%>"><%=rs3.getInt("id")%><%=rs3.getString("name")%></option>
                      
                   <%} %>
                  </select>		
              </div>
              </div>
              <%
          rs3.close();
        st3.close();
        con3.close();
        }catch(Exception e){
            e.printStackTrace();
        }
      %>
      <!-- /.department -->
      <%

      sql="SELECT * FROM users where role=? order by id desc";
      
      //out.println(sql);
      try{
      DbConnection dbcon4 = new DbConnection();
      Connection con4 = dbcon4.getConnection();
      PreparedStatement st4= con4.prepareStatement(sql);
      st4.setString(1, "teacher");
      ResultSet rs4= st4.executeQuery();
        //int i=1;
        if(rs4.isBeforeFirst()){
          out.println(" ");
        }
          
      %>
                  
      <div class="form-group row">
              <label for="staticEmail" class="col-sm-2 col-form-label">Teachers</label>
              <div class="col-sm-10">
            <select class="form-control" name="user">
                    <%while(rs4.next())		
        {	
                    %>
                      <option value="<%=rs4.getInt("id")%>"><%=rs4.getString("email")%><%=rs4.getInt("id")%></option>
                      
                   <%} %>
                  </select>		
              </div>
              </div>
              <%
          rs4.close();
        st4.close();
        con4.close();
        }catch(Exception e){
            e.printStackTrace();
        }
      %>
      <!-- /.user -->	  
      <input type="file" name="qsn">
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <!--<button type="button" class="btn btn-primary">Save changes</button>  -->
        <input type="submit" class="btn btn-info" value="Update">
        </div>
        </form>
        
      </div>
    </div>
  </div>
  
  <%

      sql="select * from examination as e inner join subjects as s on e.sub_id=s.id inner join department as d on e.dept_id=d.id inner join users u on e.user_id=u.id where e.sub_id=? ;";
      
      //out.println(sql);
      try{
      DbConnection dbcon4 = new DbConnection();
      Connection con4 = dbcon4.getConnection();
      PreparedStatement st4= con4.prepareStatement(sql);
      st4.setInt(1, rs.getInt("id"));
      ResultSet rs4= st4.executeQuery();
        //int i=1;
        if(rs4.isBeforeFirst()){
          out.println(" ");
        }
          
      %>
      <%while(rs4.next())		
        {	
                    %>
                    <% if(rs4.getBlob("question").length()!=0){%>
                      <a href="<%=request.getContextPath()%>/qsn?file=<%=rs4.getString("qsn_name")%>"><div><%=rs4.getString("qsn_name") %></div></a>
                      <div><%=rs4.getString("d.name") %></div>
                      <div><%=rs4.getString("u.email") %></div>
                    <%} %>  
                   <%} %>
                   <%
          rs4.close();
        st4.close();
        con4.close();
        }catch(Exception e){
            e.printStackTrace();
        }
      %>
  </div>
</div>
</div>
</div>
<%
  i++;
  }
  rs.close();
st.close();
con.close();
}catch(Exception e){
    e.printStackTrace();
  }
}
%>
      
      
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
  <small>Copyright &copy; 2021-<%
      GregorianCalendar cal = new GregorianCalendar();
      out.print(cal.get(Calendar.YEAR));
    %> <a href="<%=request.getContextPath()%>/login">DigiXam</a>.</small> All rights reserved.
</footer>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript">
$(function () {
    $("#example1").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false,"pageLength": 5,
      "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
  });
  </script>
 </body>
</html>
<%}%>