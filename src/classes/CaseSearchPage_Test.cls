/* Class Name  : CaseSearchPage_Test
 * Description : Test class for an Apex class CaseSearchPage
 * Created By  : Silviu Frantescu
 * Created On  : 10-03-2013
*/

@isTest
private class CaseSearchPage_Test{
    static case cas;
    private static testmethod void testAcceptCase(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';        
        insert cas;
        ApexPages.StandardController sc = new ApexPages.StandardController(cas);
        CaseSearchPage obj = new CaseSearchPage(sc);
    }   
}