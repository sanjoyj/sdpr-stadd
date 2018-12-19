dojo.require("dojo.collections.Store");
dojo.require("dojo.charting.Chart");
dojo.require('dojo.json');
var arYears = getYears();
function swapYears(){	// Contact Birth day	
if(document.getElementById('calYearPicker') != null) {	 
var select = document.getElementById('calYearPicker');	
var curValue = select.value; 	
var parentx = select.parentNode;	
parentx.removeChild(select);	 select = document.createElement('select');	 
select.size = 1;	 
select.id = 'calYearPicker';	 
select.name = 'calYearPicker';	 
parentx.appendChild(select);	}	
if(select != null) {	 for(x=0;x<120;x++) {	 select.options[x] = new Option(arYears[x], arYears[x], false, false);	 }	}}
function getYears() {	
sforce.sessionId = getCookie('sid');	sforce.connection.sessionId=sforce.sessionId;	var out = [];	// generate dates for the last 100 years	
var currentTime = new Date()	
var year = currentTime.getFullYear()	
try {	 for(x=0;x<120;x++) {	 out[x] = x+year-100;	 }	 } 
catch(error) {	 alert(error);	 }	 
return out;}
dojo.addOnLoad(swapYears);

function addLoadEvent(func) {    
var oldonload = window.onload;    
if (typeof window.onload != 'function') {        
window.onload = func;    } 
else {        window.onload = function() 
{            
if (oldonload) {                
oldonload();            }           
 func();        }    }}
addLoadEvent(function() {    
if(window.parent.document.getElementsByName("save_new" )[0]) {         
window.parent.document.getElementsByName("save_new" )[0].style.display='none';        
 window.parent.document.getElementsByName("save_new" )[1].style.display='none';     }	  
if(window.parent.document.getElementsByName("save_close" )[0]) {        
 window.parent.document.getElementsByName("save_close" )[0].style.display='none';        
 window.parent.document.getElementsByName("save_close" )[1].style.display='none';     }  
if(window.parent.document.getElementsByName("spell" )[0]) {         
window.parent.document.getElementsByName("spell" )[0].style.display='none';        
 window.parent.document.getElementsByName("spell" )[1].style.display='none';     } 
if(window.parent.document.getElementsByName("sendMail" )[0]) {         
window.parent.document.getElementsByName("sendMail" )[0].value="0";   }
if(window.parent.document.getElementsByName("sendMail" )[0]) {         
window.parent.document.getElementsByName("sendMail" )[0].style.display='none';        
window.parent.document.getElementsByName("sendMail" )[1].style.display='none';     }      
  })