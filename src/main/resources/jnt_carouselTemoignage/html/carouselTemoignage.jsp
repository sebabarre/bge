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


<jcr:nodeProperty node="${currentNode}" name="maxTemoignages" var="maxTemoignages"/>
<query:definition var="listQuery" statement="select * from [jnt:temoignage] as temoignages where ISDESCENDANTNODE(temoignages,'${currentNode.resolveSite.path}') order by temoignages.[date] desc" limit="${maxTemoignages.long}"  />
<jcr:jqom var="lastTemoignages" qomBeanName="listQuery" />

<c:forEach items="${lastTemoignages.nodes}" var="temoignage" varStatus="status">
  <c:set var="carouselIndicators">${carouselIndicators}
    <li data-target="#carousel${currentNode.identifier}" data-slide-to="${status.index}" class="${status.index eq 0?'active':''}"></li>
  </c:set>
  <c:set var="carouselItems">${carouselItems}
    <div class="item ${status.index eq 0?'active':''}">
      <template:module node="${temoignage}"/>
    </div>
  </c:set>
</c:forEach>

<div id="carouselContener">
  <div id="carousel${currentNode.identifier}" class="carousel slide slider carousel-editor" data-ride="carousel">
    <div class="temoignage_control">
      <a class="left carousel-control carousel-temoignage-control" href="#carousel${currentNode.identifier}" role="button" data-slide="prev"></a>
    </div>
    
    <div class="temoignage_carousel_content">

      <div class="carousel-inner carousel-temoignage-inner" role="listbox">
        ${carouselItems}
      </div>

      <ol class="carousel-indicators carousel-temoignage-indicators">
        ${carouselIndicators}
      </ol>
    </div>
    
    <div class="temoignage_control tc_right">
      <a class="right carousel-control carousel-temoignage-control" href="#carousel${currentNode.identifier}" role="button" data-slide="next"></a>
    </div>
  </div> 
</div>


<template:addResources type="javascript" resources="footer_1_resp.js"/>
<template:addResources type="javascript" resources="bootstrap.min.js"/>