<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
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
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  	<meta http-equiv="X-UA-Compatible" content="IE=edge;IE=9;IE=8;IE=7" />
  	
  	<meta name="description" content="Besoin de conseils pour creer votre entreprise ? BGE, Boutique de Gestion pour Entreprendre vous aide et vous conseille pour la creation de votre entreprise"/>
    <link rel="canonical" href="http://www.bgparif.com/" />
    <meta property="og:locale" content="fr_FR" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content="BGE - Boutique de Gestion pour Entreprendre" />
    <meta property="og:description" content="Besoin de conseils pour creer votre entreprise ? BGE, Boutique de Gestion pour Entreprendre vous aide et vous conseille pour la creation de votre entreprise" />
    <meta property="og:url" content="http://www.bgparif.com/" />
    <meta property="og:site_name" content="Boutique Gestion pour Entreprendre" />
  
  	<link rel="shortcut icon" href="/files/live/modules/bge/1.0-SNAPSHOT/templates/files/img/general/favicon.ico" type="image/x-icon" />
  
  	<template:addResources type="css" resources="960.css,01web.css"/>
  	<template:addResources type="css" resources="bootstrap.min.css"/>
  
  	<template:addResources type="css" resources="fonts.css" />
  	<template:addResources type="css" resources="tooltips.css" />
	<template:addResources type="css" resources="template.css" />
  	<template:addResources type="css" resources="contact.css" />
  	<template:addResources type="css" resources="header.css" />
  	<template:addResources type="css" resources="footer.css" />
  	<template:addResources type="css" resources="home.css" />
  	<template:addResources type="css" resources="target.css" />
  	<template:addResources type="css" resources="formation.css" />
  	
  	<template:addResources type="javascript" resources="jquery.min.js"/>
  	<template:addResources type="javascript" resources="tooltips.js"/>
  	<template:addResources type="javascript" resources="target.js"/>

    <title>${fn:escapeXml(renderContext.mainResource.node.displayableName)}</title>
</head>

<body>

<div class="bodywrapper">
    <template:area path="pagecontent"/>
</div>


<c:if test="${renderContext.editMode}">
    <template:addResources type="css" resources="edit.css" />
</c:if>

<template:theme/>

	<c:if test="${renderContext.editMode}">
		<script>
          	$( document ).ready(function() {
    			$( ".footer-row1" ).css( "min-height", "450px" );
			});
		</script>
   </c:if>
  
</body>
</html>
