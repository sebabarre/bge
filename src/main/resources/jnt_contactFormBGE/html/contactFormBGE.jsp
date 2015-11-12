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


<div>
	<ul class="contact-list">
		<li><span class="contact-label">Nom</span><input id="lastname" class="contact-entries"></input><span class="contact-star" title="champ obligatoire">*<span></li>
		<li><span class="contact-label">Prénom</span><input id="firstname" class="contact-entries"></input><span class="contact-star" title="champ obligatoire">*<span></li>
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
		<li><button onclick="contactValidator()" style="margin-left:150px">Envoyer</button><span class="contact-help"><span style="color:orange">*</span><span> : champ obligatoire</span></span></li>
       
	</ul>
	
</div>

<script>
function contactValidator(){
	var match = 0;
	var validator = 0;
	var sendTo = "";

  	var nameArray = new Array(
  		"Créateur/Repreneur",
		"firstname",
		"email",
		"phone",
		"profile",
		"postal",
		"object",
        "message"};	
  
	var profileArray = new Array(
		"Créateur/Repreneur",
		"Dirigeant d'entreprise",
		"Acteur des collectivités et territoires",
		"Employeur ou DRH",
		"Acteur de l'enseignement");

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
		var sendTo = "";
		switch(profile.value){
			// Créateur/Repreneur
			case profileArray[0]:
				sendTo = "accueil.paris@bge-parif.com";
				break;
			// Dirigeant d'entreprise
			case profileArray[1]:
				sendTo = "accueil.paris@bge-parif.com";
				break;
			// Acteur des collectivités et territoires
			case profileArray[2]:
				sendTo = "isabelle.larregneste@bge-parif.com";
				break;
			// Employeur ou DRH
			case profileArray[3]:
				sendTo = "isabelle.larregneste@bge-parif.com";
				break;
			// Acteur de l'enseignement
			case profileArray[4]:
				sendTo = "isabelle.larregneste@bge-parif.com";
				break;
		}
		var mailBody = prepareMailBody();

		var link = "mailto:" + sendTo
             + "&subject=" + (document.getElementById("object").value)
             + "&body=" + mailBody;

       window.location.href = link;
      
          
	}
}

function displayBorder(property, color){
	document.getElementById(property).style.border="2px solid " +color;
}

function prepareMailBody(){
	return document.getElementById("message").value.replace(/\n\r?/g, '%0A') + escape('\n\n') +
			'Envoyé par : ' + document.getElementById("firstname").value + ' ' + document.getElementById("lastname").value + escape('\n') +
			'Code postal : ' + document.getElementById("postal").value + escape('\n') +
			'Contact : ' + document.getElementById("email").value+ ' ' + document.getElementById("phone").value;
}
</script>