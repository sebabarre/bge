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
  .slider-test img{
    height:auto;
    width:120px;
  }
  
  .bx-viewport{
    height:80px !important;
  }
</style>

<c:choose>
	<c:when test="${renderContext.editMode}">
      <div style="height:100%;">
    </c:when>
    <c:otherwise>
		<div class="home-partners">
    </c:otherwise>
</c:choose>
      
          <section id="partners">
            <div class="container-fluid">
              <div class="row-fluid">
                <div class="span12">
                  <p style="color:#004a99;">PARTENAIRES</p>
                  
                  <c:choose>
                    <c:when test="${renderContext.editMode}">
                      <div>
                        <template:module path="*" nodeTypes="jnt:imageWithLink"/> 
                        <ul>
                          <c:forEach items="${jcr:getChildrenOfType(currentNode, 'jnt:imageWithLink')}" var="item" varStatus="loopIndex">
                            <li class="slider-test">
                              <template:module node="${item}" editable="true"/>
                            </li>
                          </c:forEach>
                        </ul>
                      </div>
                    </c:when>
                    
                    <c:otherwise>
                      <div class="div-slider">
                        <ul class="bxslider partner-slider">
                          <c:forEach items="${jcr:getChildrenOfType(currentNode, 'jnt:imageWithLink')}" var="item" varStatus="loopIndex">
                            <li style>
                              <template:module node="${item}" editable="true"/>
                            </li>
                          </c:forEach>
                        </ul>
                      </div>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </section>
      </div>
  </div>



<template:addResources type="javascript" resources="jquery.bxslider.min.js"/>
<script>
  jQuery(document).ready(function(){
  jQuery('.bxslider').bxSlider({
  speed : 1000,
  minSlides: 7,
  maxSlides: 7,
  auto:true,
  controls:false,
  pager:false,
  slideWidth: 120,
  slideMargin: 10});
  });
</script>