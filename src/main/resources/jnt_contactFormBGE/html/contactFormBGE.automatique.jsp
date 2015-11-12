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
  .focus{
    min-width:600px;
  }
  
  @media screen and (max-width: 1024px){
    .focus{
      min-width:0;
    }
  }
  
  .alert-init{
    display:none; 
  }
</style>

<bean class="org.jahia.modules.bge.mail.action.Mail" >
        <property name="name" value="mail"/>
        <property name="jcrTemplate" ref="jcrTemplate"/>
</bean>


<div style="margin-top:10px; margin-bottom:10px;">
  <div id="alert" class="alert alert-success alert-init">Votre mail a été envoyé.</div>
  <form id="form" style="margin-bottom:0;">
  	<ul class="contact-list">
      	<li><span class="contact-label">Prénom</span><input id="firstname" class="contact-entries"></input><span class="contact-star" title="champ obligatoire">*<span></li>
		<li><span class="contact-label">Nom</span><input id="lastname" class="contact-entries"></input><span class="contact-star" title="champ obligatoire">*<span></li>
		<li><span class="contact-label">Email</span><input id="email" class="contact-entries"></input><span class="contact-star" title="champ obligatoire">*<span></li>
		<li><span class="contact-label">Téléphone</span><input id="phone" class="contact-entries"></input></li>
		<li><span class="contact-label">Profil</span>
			<select id="profile" class="contact-entries contact-select">
				<option>Créateur/Repreneur</option>
				<option>Dirigeant d'entreprise</option>
				<option>Acteur des collectivités et territoires</option>
				<option>Employeur ou DRH</option>
				<option>Acteur de l'enseignement</option>
			</select>
			<span class="contact-star">*<span>
		</li>
		<li><span class="contact-label">Code Postal</span><input id="postal" class="contact-entries"></input><span class="contact-star" title="champ obligatoire">*<span></li>
		<li><span class="contact-label">Objet du message</span><input id="object" class="contact-entries"></input><span class="contact-star" title="champ obligatoire">*<span></li>
		<li><span class="contact-label">Message</span><textarea id="message" class="contact-entries contact-textarea" placeholder="Veuillez nous écrire votre message ici."></textarea><span class="contact-star" title="champ obligatoire">*<span></li>
		
	</ul>
  </form>
          <button onclick="contactValidator()" style="margin-left:175px">Envoyer</button><span class="contact-help"><span style="color:orange">*</span><span> : champ obligatoire</span></span>
</div>


<script type="text/javascript">
function contactValidator(){
  // Remove alert success
  	$("#alert").addClass("alert-init");
  
	var match = 0;
	var validator = 0;
	var sendTo = "";
	var profileArray = new Array(
		"Créateur/Repreneur",
		"Dirigeant d'entreprise",
		"Acteur des collectivités et territoires",
		"Employeur ou DRH",
		"Acteur de l'enseignement");
	var nameArray = new Array(
		"lastname",
		"firstname",
		"email",
		"phone",
		"profile",
		"postal",
		"object",
		"message");

	for(var row=0; row<8; row++){
		var color = "red";
		var property = document.getElementById(nameArray[row]);

		//case phone optional
		if(property.id != "phone"){
			switch(row){
				// case profile
				case 4:
					for(var i=0;i<5;i++){
						if(profile.value == profileArray[i]){
							match = 1;
							color = "green";
							validator++;
						}
					}
					break;
				default:
					if(property.value != ""){
						color = "green";
						validator++;
					}
			}
			displayBorder(nameArray[row],color);
		}
	}

	// All parameters set
	if(validator == 7){
      
      $("#alert").removeClass("alert-init");
      $("#form").submit();
	}
}

function displayBorder(property, color){
	document.getElementById(property).style.border="2px solid " +color;
}
  
$('#form').on('submit',function (e) {
	var form = document.getElementById('form');
    var mail = {
          'j:lastname': form.lastname.value,
          'j:firstname': form.firstname.value,
          'j:email': form.email.value,
          'j:phone': form.phone.value,
          'j:profile': form.profile.value,
          'j:postal': form.postal.value,
          'j:object': form.object.value,
          'j:message': form.message.value,
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
  
  $(document).ready(function() {

    $('#message').blur(function() {
        $('#message').removeClass("focus");
      })
      .focus(function() {
        $(this).addClass("focus")
      });
  });
</script>