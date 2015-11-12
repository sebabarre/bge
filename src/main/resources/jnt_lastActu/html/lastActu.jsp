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

<jcr:nodeProperty node="${currentNode}" name="maxActu" var="maxActu"/>

<c:if test="${empty param.page}">
  <fmt:formatNumber var="offsetStarter" value="0" type="number" pattern="#"/>
  <fmt:formatNumber var="currentPage" value="1" type="number" pattern="#"/>  
</c:if>
<c:if test="${not empty param.page}">
  <fmt:formatNumber var="offsetStarter" value="${(param.page-1)*maxActu.long}" type="number" pattern="#"/>
  <fmt:formatNumber var="currentPage" value="${param.page}" type="number" pattern="#"/>
</c:if>

<c:choose>
  <c:when test="${!empty param.cat && !(currentNode.properties['view'].string eq 'home')}">  
    <jcr:sql var="nbItems" sql="SELECT * FROM [jnt:actualite] as actualites WHERE ISDESCENDANTNODE(actualites,'${currentNode.resolveSite.path}') AND actualites.[j:defaultCategory] = '${param.cat}'"/>
  </c:when>
  <c:otherwise>
    <jcr:sql var="nbItems" sql="SELECT * FROM [jnt:actualite] as actualites WHERE ISDESCENDANTNODE(actualites,'${currentNode.resolveSite.path}')"/>
  </c:otherwise>
</c:choose>


<fmt:formatNumber var="nbPages" value="${(nbItems.nodes.size/maxActu.long)+(1-((nbItems.nodes.size/maxActu.long)%1))%1}" type="number"/>

<c:url value="${url.mainResource}" var="nextLinks">  
  <c:param name="page" value="${currentPage+1}"/>
</c:url>
<c:url value="${url.mainResource}" var="prevLinks">
  <c:param name="page" value="${currentPage-1}"/>
</c:url>

<c:choose>
  <c:when test="${!empty param.cat && !(currentNode.properties['view'].string eq 'home')}">
        <query:definition var="listQuery" statement="SELECT * FROM [jnt:actualite] as actualites WHERE ISDESCENDANTNODE(actualites,'${currentNode.resolveSite.path}') AND actualites.[j:defaultCategory] = '${param.cat}' order by actualites.[date] desc" limit="${maxActu.long}"  offset="${offsetStarter}"/>
<jcr:jqom var="lastActualites" qomBeanName="listQuery" />
    </c:when>
  <c:otherwise>
    <query:definition var="listQuery" statement="select * from [jnt:actualite] as actualites where ISDESCENDANTNODE(actualites,'${currentNode.resolveSite.path}') order by actualites.[date] desc" limit="${maxActu.long}"  offset="${offsetStarter}"/>
<jcr:jqom var="lastActualites" qomBeanName="listQuery" />
      </c:otherwise>
</c:choose>


<div class="row ${currentNode.properties['view'].string eq 'home'? 'actu-block' : ''}" id="${currentNode.properties['view'].string eq 'home'? 'actu' : ''}">
<c:forEach items="${lastActualites.nodes}" var="actualite" varStatus="status">
  <template:module node="${actualite}" view="${currentNode.properties['view'].string}"/>
</c:forEach>
</div>

<c:if test="${currentNode.properties['view'].string eq 'page'}">
  <p class="last-pagination">
<c:if test="${currentPage-1 > 0}">
  <a href="${prevLinks}">Precedent</a>
</c:if>
<c:if test="${currentPage+1 <= nbPages}">
  <a href="${nextLinks}">Suivant </a>
</c:if>
  </p>
</c:if>