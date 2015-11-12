package org.jahia.modules.bge.mail.action;
import org.jahia.services.mail.*;
import org.jahia.bin.Action;
import org.json.JSONObject;
import org.jahia.bin.ActionResult;
import org.jahia.bin.Render;
import org.jahia.services.content.JCRCallback;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.content.JCRTemplate;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.URLResolver;
import org.json.JSONException;
import org.slf4j.Logger;

import org.jahia.services.SpringContextSingleton;
import javax.jcr.RepositoryException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;


import org.jahia.services.mail.MailSettings;
import org.jahia.services.mail.MailServiceImpl;


public class Mail extends Action {

  	public MailServiceImpl mailService;
  
    JCRTemplate jcrTemplate;
 
    public void setJcrTemplate(JCRTemplate jcrTemplate) {
        this.jcrTemplate = jcrTemplate;
    }
 
    @Override
    public ActionResult doExecute(HttpServletRequest req, RenderContext renderContext, final Resource resource, JCRSessionWrapper session, final Map<String, List<String>> parameters, URLResolver urlResolver) throws Exception {
   		
      // PARAMETRAGE DES MAILS
      // =====================
      // accueil.paris@bge-parif.com / isabelle.larregneste@bge-parif.com / site.bge-parif@bge-parif.com
      
      // Expéditeur
      	String sender = "site.bge-parif@bge-parif.com";
      
      // En copie
      	String sendCC = "site.bge-parif@bge-parif.com";
      	
      // Destinatire pour Créateur/Repreneur
      	String profileOne = "accueil.paris@bge-parif.com";
      
      // Destinatire pour Dirigeant d'entreprise
        String profileTwo = "accueil.paris@bge-parif.com";
      
      // Destinatire pour Acteur des collectivités et territoires
        String profileThree = "isabelle.larregneste@bge-parif.com";
      
      // Destinatire pour Employeur ou DRH
        String profileFour = "isabelle.larregneste@bge-parif.com";
      
      // Destinatire pour Acteur de l'enseignement
        String profileFive = "isabelle.larregneste@bge-parif.com";
      	
      
      
      	String lastname = parameters.get("j:lastname").get(0);
        String firstname = parameters.get("j:firstname").get(0);
        String email = parameters.get("j:email").get(0);
        String phone = parameters.get("j:phone").get(0);
      	String profile = parameters.get("j:profile").get(0);
      	String postal = parameters.get("j:postal").get(0);
      	String object = parameters.get("j:object").get(0);
      	String message = parameters.get("j:message").get(0);
      
      	message = message.replace("\n", "<br/>");
      
      	String[] profileArray = new String[]{
			"Créateur/Repreneur",
			"Dirigeant d'entreprise",
			"Acteur des collectivités et territoires",
			"Employeur ou DRH",
			"Acteur de l'enseignement"
      	};
      	
      	String sendTo = "";
      	
      	switch(profile){
			case "Créateur/Repreneur":
				sendTo = profileOne;
				break;
			case "Dirigeant d'entreprise":
				sendTo = profileTwo;
				break;
			case "Acteur des collectivités et territoires":
				sendTo = profileThree;
				break;
			case "Employeur ou DRH":
				sendTo = profileFour;
				break;
			case "Acteur de l'enseignement":
				sendTo = profileFive;
				break;
          	// Si erreur
            default:
            	sendTo = "alexandre.delisle@accenture.com";
          		object = object+ " ERROR";
		}
      
      	String template =  "<div><h2 style='color:#284c96'>Message</h2><div>" +message+ "</div><br/><h2 style='color:#284c96'>Formulaire</h2><p>Envoyé par : " +firstname+ " " +lastname+ "</p><p>Profil : " +profile+" </p><p>Code postal : " +postal+ "</p><p>Contact : " +email+ "</p><p>Téléphone : " +phone+ "</p></div>";
        
      	MailSettings mSettings = new MailSettings(true,"smtps://email-smtp.eu-west-1.amazonaws.com:465?username=AKIAJC244MHEKTMNHDDA&password=AutXpBbwO6R1fIXp5ZYAO2vAAOYtztGC2cyH9PEmAXa8","site.bge-parif@bge-parif.com","site.bge-parif@bge-parif.com","Paranoid");
              	
        setMailService((MailServiceImpl) SpringContextSingleton.getBean("MailService"));
        mailService.sendMessage(sender, sendTo, sendCC, null, object, null, template);  
      	JSONObject json = new JSONObject();
      	json.append("error", "false");
      
      	return new ActionResult(HttpServletResponse.SC_OK, null, json);
    }
  
    public void setMailService(MailServiceImpl mailService) {
        this.mailService = mailService;
    }
  
}