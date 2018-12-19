var j$ = jQuery.noConflict();
//Add All the name of the components that you want to hide.
var hideComponentArray = ['Injection Box'];
j$(function(){
   j$("h2.brandPrimaryFgr").each(function(){
      if(j$.inArray(j$(this).text(), hideComponentArray) != -1){
         //Hiding the entire div.
         j$(this).parent("div.sidebarModuleHeader").parent("div.linksModule").hide();
      }
    });
	});
