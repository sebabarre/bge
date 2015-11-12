<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>


<template:addResources type="css" resources="slider.css"/>

<jcr:nodeProperty var="bgimage" node="${currentNode}" name="bgimage"/>
<c:set var="bgimageUrl" value="${bgimage.node.url}"/>
<section class="slider-container illustration-section ">
    <div class="container-fluid ">
        <c:choose>
        <c:when test="${renderContext.editMode}">
        <ul>
            <c:forEach items="${jcr:getChildrenOfType(currentNode, 'jnt:sampleCarouselItem')}" var="item" varStatus="status">
                <li>
                    <template:module node="${item}" editable="true"/>
                </li>
            </c:forEach>
        </ul>
         <template:module path="*" nodeTypes="jnt:sampleCarouselItem"/>   
        </c:when>
        <c:otherwise>
        <div id="carousel${currentNode.identifier}" class="carousel slide slider" data-ride="carousel">
           
                <c:forEach items="${jcr:getChildrenOfType(currentNode, 'jnt:sampleCarouselItem')}" var="item" varStatus="status">
                  
                    <c:set var="carouselInner">${carouselInner}
                        <c:set var="classItem" value="${status.index eq 0?'active':''} item"/>
                        <div class="${classItem}">
                            <template:module node="${item}"/>
                        </div>
                    </c:set>
                </c:forEach>
            
            <div class="carousel-inner">
                    ${carouselInner}
            </div>

            </c:otherwise>
            </c:choose>
        </div>
        <c:if test="${renderContext.editMode}">
          <script>
          	$( document ).ready(function() {
    			$( ".carousel-cible" ).css( "position", "relative" );
			});
          </script>
        </c:if>
</section>

<template:addResources type="javascript" resources="jquery.min.js,bootstrap.min.js"/>
