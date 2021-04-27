<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" info="Report" session="false" %>
<%!  
private Connection con;
private PreparedStatement pst1,pst2;

public void jspInit(){
	//getting accesss to servlet config object
	ServletConfig config=getServletConfig();
	//reading jsp init params
	String driver=config.getInitParameter("driver");
	String url=config.getInitParameter("url");
	String user=config.getInitParameter("user");
	String pwd=config.getInitParameter("pwd");
	try{
		//load driver class
		Class.forName(driver);
		//establish the connection
		con=DriverManager.getConnection(url, user, pwd);
		//prepared statement
		pst1=con.prepareStatement("INSERT INTO JSP_EMPLOYEE VALUES(EMP_SEQ1.NEXTVAL,?,?,?)");
		pst2=con.prepareStatement("SELECT EMPNO,EMPNAME,EMPADDRS,EMPSAL FROM JSP_EMPLOYEE");
	}
	catch(SQLException se){
		se.printStackTrace();
	}
	catch(ClassNotFoundException cfe){
		cfe.printStackTrace();
	}
	catch(Exception e){
		e.printStackTrace();
	}
} %>


<%
   //getting s      value whether it is submit button or hyperlink
   String val=request.getParameter("s1");
   if(val.equalsIgnoreCase("Register")){
	   //read form data
	   String name=request.getParameter("ename");
	   String addrs=request.getParameter("eaddrs");
	   Float salary=Float.parseFloat(request.getParameter("esalary"));
	   //setting values to insert query
	   pst1.setString(1,name);
	   pst1.setString(2,addrs);
	   pst1.setFloat(3,salary);
	   //execute query
	   int result=pst1.executeUpdate();
	   //process the results
	   if(result==1){ %> 
		   <h1 style="color: green;text-align:center;"> Employee Registered</h1>
 <%}
	   else { %>
	   <h1 style="color: red;text-align:center;"> Employee Not Registered</h1>
  <%}
}else{
   //executing the select query
   ResultSet rs=pst2.executeQuery();

 %>
<table border="1" align="center" bgcolor="pink">
  <tr>
    <th>EmpNo</th>
    <th>EmpName</th>
    <th>EmpAddrs</th>
    <th>EmpSalary</th>
  </tr>
  <% while(rs.next()){  %>
  <tr>
    <td><%=rs.getInt(1) %></td>
    <td><%=rs.getString(2) %></td>
     <td><%=rs.getString(3) %></td>
      <td><%=rs.getFloat(4) %></td>
  </tr>
  <%} %>
</table>
<%} %>

<br>
<a href="EmpForm.html">Home</a>
<%! public void jspDestroy(){
	try{
		if(pst1!=null){
			pst1.close();
		}
	}catch(SQLException se){
		se.printStackTrace();
	}
	try{
		if(pst2!=null){
			pst2.close();
		}
	}catch(SQLException se){
		se.printStackTrace();
	}
	try{
		if(con!=null){
			con.close();
		}
	}catch(SQLException se){
		se.printStackTrace();
	}
}

%>


