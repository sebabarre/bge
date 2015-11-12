$(document).ready(function(){
  var page = document.URL.substr(document.URL.lastIndexOf('/')+1,document.URL.length);
  page = page.substr(0, page.lastIndexOf('.'));
  
  var url =  document.URL.substr(document.URL.indexOf('/'),document.URL.length);

  switch(page){
    case "le-bus":
    case "le-coworking":
    case "nos-couveuses":
      $('#' +page).addClass('menu-active');
      break;
    case "formations":
    case "formations-vendre":
    case "formations-gerer":
    case "formations-immatriculer":
    case "formations-communiquer":
    case "formations-se-perfectionner":
      $("#formations").addClass('menu-active');
      break;
    case "notre-fondatrice":
    case "notre-histoire":
    case "notre-equipe":
    case "nos-resultats":
    case "nos-partenaires":
    case "reseau-national":
      $('#qui-sommes-nous').addClass('menu-active');
      break;
    default:
  }
});