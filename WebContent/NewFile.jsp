<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
body {
text-align: center;
    margin-top: 120px;
    }
</style>
</head>

<body >
					<c:out value="${a}" /><br><br>
					<c:out value="${b}" /><br><br>
								
						<input class="button" type="button" value="Home Page" onclick="location.href = 'index.jsp';"
			style="width: 200px; height: 40px; " /> 
</body>

</html>