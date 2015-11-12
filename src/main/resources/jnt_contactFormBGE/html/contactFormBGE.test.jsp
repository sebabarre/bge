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

<bean class="org.jahia.modules.bge.mail.action.Mail" >
        <property name="name" value="mail"/>
        <property name="jcrTemplate" ref="jcrTemplate"/>
</bean>


<html>
  <head>
    <title>Spring MVC Form Handling</title>
  </head>
  <body>
    
    <h2>Student Information</h2>
    <form id="form">
      From : <input type="text" name="from" id="from"/>
      To : <input type="text" name="to" id="to"/>
      Subject : <input type="text" name="subject" id="subject"/>
      Message : <textarea  name="content" id="content"></textarea>
      <input type="submit" value="Send" />
    </form>
    
    <script type="text/javascript">
      
       $('#form').on('submit',function (e) {
           var form = document.getElementById('form');
        var mail = {
          'j:from': form.from.value,
          'j:to': form.to.value,
          'j:subject': form.subject.value,
          'j:content': form.content.value
        };
        console.log(mail);
        
        $.ajax({
        method: "POST",
        url: "<c:url value='${url.base}${currentNode.path}'/>.mail.do",
        data: mail,
      })
        .done(function( msg ) {
          console.log(msg);
          console.log( "Data Saved: " + msg );
        })
         .fail(function(jqXHR, textStatus) {
           console.log(jqXHR);
            console.log( "error"+ textStatus );
          });
        e.preventDefault();
       });
    </script>
  </body>
</html>
