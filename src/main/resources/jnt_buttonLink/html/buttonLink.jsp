<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="id" value="${currentNode.properties['url'].string}" />

<c:set var="lastIndexOf_slash" value="/"/>
<c:set var="lastIndexFoundAt_slash" value=""/>
<c:set var="lastIndexOf_point" value="."/>
<c:set var="lastIndexFoundAt_point" value=""/>
<c:set var="myStrSize" value="${fn:length(id) }"/>
<c:set var="indexIn" value="0"/>
<c:set var="indexOut" value="1"/>


<c:forEach var="i" begin="0" end="${myStrSize}">
  <c:if test="${indexOut <= myStrSize }">
    <c:set var="char" value="${fn:substring(id, indexIn, indexOut) }"/>
    <c:if test="${char == lastIndexOf_slash }">
      <c:set var="lastIndexFoundAt_slash" value="${i}"/>
    </c:if>
    <c:set var="indexIn" value="${indexIn + 1 }"/>
    <c:set var="indexOut" value="${indexOut + 1 }"/>
  </c:if>
</c:forEach>

<c:set var="id" value="${fn:substring(id,lastIndexFoundAt_slash+1,myStrSize)}"/>
<c:set var="indexIn" value="0"/>
<c:set var="indexOut" value="1"/>
<c:set var="myStrSize" value="${fn:length(id) }"/>

<c:forEach var="i" begin="0" end="${myStrSize}">
	<c:if test="${indexOut <= myStrSize }">
    	<c:set var="char" value="${fn:substring(id, indexIn, indexOut) }"/>     
        <c:if test="${char == lastIndexOf_point }">
        	<c:set var="lastIndexFoundAt_point" value="${i}"/>
        </c:if>
        <c:set var="indexIn" value="${indexIn + 1 }"/>
        <c:set var="indexOut" value="${indexOut + 1 }"/>
   	</c:if>
</c:forEach>


<c:set var="id" value="${fn:substring(id,0,lastIndexFoundAt_point)}"/>

<a href="${currentNode.properties['url'].string}" id="${id}" target="_self">${currentNode.properties['name'].string}</a>