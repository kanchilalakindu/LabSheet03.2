<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.Item"%>

<%
//update
if (request.getParameter("update_itemID") != null) {
	Item itemObj = new Item();
	session.setAttribute("is_in_update_mode", request.getParameter("update_itemID"));
}
//setting data
String itemCode;
String itemName;
String itemPrice;
String itemDesc;
if (String.valueOf(session.getAttribute("is_in_update_mode")) == ""
		|| session.getAttribute("is_in_update_mode") == null) {
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";
}
// insert when click save button
//update
if (request.getParameter("itemCode") != null && (
		 session.getAttribute("is_in_update_mode") != null)) {
	Item itemObj = new Item();
	String stsMsg = itemObj.updateItem(Integer.parseInt(String.valueOf(session.getAttribute("is_in_update_mode"))),
	request.getParameter("itemCode"), request.getParameter("itemName"), request.getParameter("itemPrice"),
	request.getParameter("itemDesc"));
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";
//System.out.println("xxxxx");
	session.setAttribute("is_in_update_mode", "");
	session.setAttribute("statusMsg", stsMsg);
} else if (request.getParameter("itemCode") != null) { //insert new
	Item itemObj = new Item();
	String stsMsg = itemObj.insertItem(request.getParameter("itemCode"), request.getParameter("itemName"),
	request.getParameter("itemPrice"), request.getParameter("itemDesc"));
	session.setAttribute("statusMsg", stsMsg);
	//System.out.println("yyyy");
}
//delete
if (request.getParameter("itemID") != null) {
	Item itemObj = new Item();
	String stsMsg = itemObj.removeItem(Integer.parseInt(request.getParameter("itemID")));
	session.setAttribute("statusMsg", stsMsg);
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Items Management</title>
</head>
<body>
	<h1>Items Management</h1>
	<h3>
		<%
		out.print(session.getAttribute("statusMsg"));
		%>
	</h3>
	<form method="post" action="items.jsp">
		Item code: <input name="itemCode" value="<%out.print(itemCode);%>"
			type="text"><br> Item name: <input name="itemName"
			value="<%out.print(itemName);%>" type="text"><br> Item
		price: <input name="itemPrice" value="<%out.print(itemPrice);%>"
			type="text"><br> Item description: <input
			name="itemDesc" value="<%out.print(itemDesc);%>" type="text"><br>
		<input name="btnSubmit" type="submit" value="Save">
	</form>
	<br>
	<p>
		<i>!!to update item , first fill form and then click update button
			you want to update!!</i>
	</p>
	<br>
	<%
	Item itemObj = new Item();
	out.print(itemObj.readItems());
	%>



</body>
</html>