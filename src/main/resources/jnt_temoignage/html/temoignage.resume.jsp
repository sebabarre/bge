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
<template:addResources type="css" resources="bootstrap.min.css"/>
<c:url value="${url.base}${currentNode.path}.html" var="links" />
<c:set value="${currentNode.properties['jcr:title'].string}" var="title"/>
<c:set value="${currentNode.properties['resume'].string}" var="shortContent" />
<fmt:formatDate value="${currentNode.properties['date'].time}" pattern="dd/MM/yyyy" var="date"/>
<c:set value="${currentNode.properties['image']}" var="image" />

<c:forEach items="${assignedCategories}" var="category" varStatus="status">
        <c:if test="${not empty category.node}">
            <p>${category.node.properties['jcr:title'].string}</p>
        </c:if>
    </c:forEach>

<div class="row last-page">
 <c:if test="${not empty image}">
  <div class="col-md-4"> 
      <c:url value="${url.files}${image.node.path}" var="imageUrl"/>
      <a href="${links}"><img src="${imageUrl}" alt="${image.string}" /></a>  
  </div>
  </c:if>
  <div class=" ${not empty image?'col-md-8':'col-md-12'}">
    <h2><a href="${links}">${title}</a></h2>
    <p class="temoignage-date">${date}</p>
    <p>${shortContent}</p>
    <a href="${links}">Lire la suite ...</a>
  </div>
</div>