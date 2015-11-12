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
<c:url value="${url.base}${currentNode.path}.html" var="links" />
<query:definition var="listQuery" statement="select * from [jnt:actualite] as actualites where ISDESCENDANTNODE(actualites,'${currentNode.resolveSite.path}') order by actualites.[date] desc"/>
<jcr:jqom var="lastActus" qomBeanName="listQuery" />
<fmt:formatDate value="${currentNode.properties['date'].time}" pattern="dd/MM/yyyy" var="date"/>
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="assignedCategories"/>


<c:forEach items="${lastActus.nodes}" var="actu" varStatus="status">
  <c:if test="${actu.path eq currentNode.path}">
    <c:set var="nextIndex" value="${status.index +1}"/>
    <c:set var="prevIndex" value="${status.index -1}"/>
  </c:if>
</c:forEach>

<c:forEach items="${lastActus.nodes}" var="actu" varStatus="status">
  <c:if test="${status.index eq prevIndex}">
    <c:set var="prevActu" value="${actu.path}"/>
  </c:if>
  <c:if test="${status.index eq nextIndex}">
    <c:set var="nextActu" value="${actu.path}" />
  </c:if>
</c:forEach>

<div class="container">
    <div class="thebreadcrumb" >
    	<ul class="breadcrumb">
        	<li >
            	<a href="/sites/bge/accueil.html">Accueil</a><span class="divider">></span>
            </li>
      		<li >
                <a href="/sites/bge/accueil/actualites.html">Actualités</a><span class="divider">></span>
            </li>
            <li class="active">
                ${currentNode.properties['jcr:title'].string}
            </li>
    	</ul>
	</div>
</div>

<h2>${currentNode.properties['jcr:title'].string}</h2>
<p class="categories">
<c:forEach items="${assignedCategories}" var="category" varStatus="status">
  <c:if test="${not empty category.node}">
    <c:url var="categoryLinks" value="${url.base}/sites/bge/accueil/actualites.html">
      <c:param value="${category.node.identifier}" name="cat"></c:param>
    </c:url>
    
    <a href="${categoryLinks}">${category.node.properties['jcr:title'].string}</a>
    <c:if test="${!status.last}">, </c:if>
    
   
  </c:if>
</c:forEach>
</p>

<p>${currentNode.properties['content'].string}</p>
<p class="actualite-date">${date}</p>

<p class="view-pagination">
<c:if test="${!empty prevActu}">
  <a href="${url.base}${prevActu}.html">Précédent</a>
</c:if>
<c:if test="${!empty nextActu}">
  <a href="${url.base}${nextActu}.html">Suivant</a>
</c:if>
</p>