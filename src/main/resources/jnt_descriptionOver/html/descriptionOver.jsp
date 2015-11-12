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

<style>
.bge-tooltip {
    border:1px solid #004a99;
    width:600px;
    position:absolute;
    left:20%;
    background-color: #ededee;
    color: #004a99;
    z-index:10;
    padding:10px;
}
  
.bge-hide{
	display: none;
}
</style>


<c:set var="id" value="${currentNode.properties['LinkID'].string}"/>
<c:set var="htmlBody" value="${currentNode.properties['Description'].string}"/>

<%-- setup --%>
<% pageContext.setAttribute("carriageReturn", "\r"); %> 
<% pageContext.setAttribute("newLine", "\n"); %> 
<c:set var="singleQuotes">'</c:set>
<c:set var="singleQuotesReplace">\'</c:set>
<c:set var="doubleQuotes">"</c:set>
<c:set var="doubleQuotesReplace">\"</c:set>
<c:set var="backslash">\</c:set>
<c:set var="backslashReplace">\\</c:set>

<%-- your string --%>
<c:set var="description" value="${
  fn:replace(
    fn:replace(
      fn:replace(
        fn:replace(
          fn:replace(htmlBody, backslash, backslashReplace),
        carriageReturn, ' '),
      newLine, ' '), 
    singleQuotes, singleQuotesReplace),
  doubleQuotes, doubleQuotesReplace)
}" />

<c:set var="idTooltip" value="${id}-tooltip"/>


<c:choose>
  
	<c:when test="${renderContext.editMode}">
      <div style="margin-top:10px;margin-bottom:10px;">
        <p style="color:#004a99;font-weight:bold;">Tooltip</p>
        <p>Lien sur l'ID : ${id}</p>
        <div class="bge-tooltip" style="position:relative;left:0">${description}</div>
      </div>
    </c:when>
  
    <c:otherwise>
      <script>
       $(function(){
         $("#${id}").hover(function() {
           $("#${idTooltip}").removeClass("bge-hide");
            },
            function() {
                $("#${idTooltip}").addClass("bge-hide");
            });
        });
		
        $("#${id}").after('<div id="${idTooltip}" class="bge-tooltip bge-hide"><c:out value="${description}" escapeXml="false" /></div>');
      </script>
    </c:otherwise>
  
</c:choose>
      
