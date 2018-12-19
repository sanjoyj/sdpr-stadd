public with sharing class ObjectHelper {
    
    public static string getObjectPrefix(String objectName) {
        return Schema.getGlobalDescribe().get(objectName).getDescribe().getKeyPrefix();
    }
    
    public static boolean isAccessible(String objectName) {
        sObject o = Schema.getGlobalDescribe().get(objectName).newSObject();
        return o.getsObjectType().getDescribe().isAccessible();
    }

    // Returns Map of Field Label | ID for the sOBject 
    public static map<String, String> fieldIdMap(String objectName){
      try {
          sObject o = Schema.getGlobalDescribe().get(objectName).newSObject();
          Boolean createable = o.getsObjectType().getDescribe().isCreateable();
          if (!createable) {
            return new Map<String, String>();
          }
          map<String, String> fieldIdMap = new map<String, String>();
          if(null!= objectName && objectName.trim() != '') {          
              PageReference p = new PageReference('/' +  
                  getObjectPrefix(objectName) + '/e?nooverride=1');   
              
              String html = !Test.isRunningTest() ? p.getContent().toString() : '';
              Matcher m = Pattern.compile('<label for="(.*?)">(<span class="requiredMark">\\*</span>)?(.*?)</label>').matcher(html);
              while(m.find()) {
                  String label = m.group(3);
                  String id = m.group(1);
                  fieldIdMap.put(label, id);
              }
          }
          return fieldIdMap;
      } catch (Exception e) {
          System.debug(e);
      }
      return new Map<String, String>();
    }
    
}