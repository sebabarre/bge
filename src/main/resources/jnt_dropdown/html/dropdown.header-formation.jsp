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
  .header-list:hover{
   background-color:#ededee !important;
  }
  
  .header-list>a{
    color:#004a99 !important;
  }
  
  .header-list>a:hover{
    background-image:none !important;  
  }  
</style>

<div id="formations" class="dropdown">
  <a href="/sites/bge/accueil/formations.html" style="text-decoration:none;height:100%;display:block;position:relative;">${currentNode.properties['name'].string}
    <span class="caret" style="position:absolute;bottom:2px;left:45%;"></span>
  </a>
  <ul class="dropdown-menu" style="top:90%;">
    <c:forEach items="${jcr:getChildrenOfType(currentNode, 'jnt:buttonLink')}" var="item" varStatus="loopIndex">
      <li class="header-list">
        <template:module node="${item}" editable="true"/>
      </li>
    </c:forEach>
  </ul>
  <template:module path="*" nodeTypes="jnt:buttonLink"/> 
</div>

<script>
  $(function(){
      $('.dropdown').hover(function() {
          $(this).addClass('open');
      },
      function() {
          $(this).removeClass('open');
      });
  });
</script>