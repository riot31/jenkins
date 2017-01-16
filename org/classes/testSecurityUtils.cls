/*----------------------------------------------------------------------------------------------- */
/*                                                                                                */
/* This class contains test methods for SFDCSecurityUtils class.                                  */
/*                                                                                                */
/* METHODS AND CLASSES:                                                                           */
/* test_insert:                 runs tests for SFDCSecurityUtils.                                 */
/* test_update:                 runs tests for SFDCSecurityUtils.                                 */
/* test_upsert:                 runs tests for SFDCSecurityUtils.                                 */
/* test_delete:                 runs tests for SFDCSecurityUtils.                                 */
/* test_updateEx:               runs tests for SFDCSecurityUtils.                                 */
/* test_insertEx:               runs tests for SFDCSecurityUtils.                                 */
/* test_insertEx2:              runs tests for SFDCSecurityUtils.                                 */
/*                                                                                                */
/*------------------------------------------------------------------------------------------------*/

@isTest(SeeAllData = false)
private class testSecurityUtils {

    /*--------------------------------------------------------------------------------------------*/
    /*                                                                                            */
    /* METHOD: test_insert                                                                        */
    /*                                                                                            */
    /* This method runs tests for SFDCSecurityUtils.                                              */
    /*                                                                                            */
    /*--------------------------------------------------------------------------------------------*/

    static testmethod void test_insert(){
        Test.startTest();
        Account testAcc = new Account();
        testAcc.Name = 'Test Name';
        ESAPI.securityUtils().validatedInsert(new List<Account>{testAcc}); //Security insert
        System.assert(![SELECT Id FROM Account WHERE Name = 'Test Name'].isEmpty());
        Test.stopTest();
    }

    /*--------------------------------------------------------------------------------------------*/
    /*                                                                                            */
    /* METHOD: test_update                                                                        */
    /*                                                                                            */
    /* This method runs tests for SFDCSecurityUtils.                                              */
    /*                                                                                            */
    /*--------------------------------------------------------------------------------------------*/

    static testmethod void test_update(){
        Account testAcc = new Account();
        testAcc.Name = 'Test Name';
        insert testAcc;
        testAcc.Name = 'Test Name2';
        Test.startTest();
        ESAPI.securityUtils().validatedUpdate(new List<Account>{testAcc}); //Security update
        ESAPI.securityUtils().validatedUpsert(new List<Account>{testAcc}); //Security upsert
        System.assert([SELECT Name FROM Account WHERE Id = :testAcc.Id][0].Name == 'Test Name2');
        Test.stopTest();
    }

    /*--------------------------------------------------------------------------------------------*/
    /*                                                                                            */
    /* METHOD: test_upsert                                                                        */
    /*                                                                                            */
    /* This method runs tests for SFDCSecurityUtils.                                              */
    /*                                                                                            */
    /*--------------------------------------------------------------------------------------------*/

    static testmethod void test_upsert(){
        Account testAcc = new Account();
        testAcc.Name = 'Test Name';
        insert testAcc;
        testAcc.Name = 'Test Name2';
        Test.startTest();
        ESAPI.securityUtils().validatedUpsert(new List<Account>{
                testAcc, 
                new Account(Name = 'Test2')
            }
        );
        System.assert(![SELECT Id FROM Account WHERE Name = 'Test Name2'].isEmpty());
        Test.stopTest();
    }

    /*--------------------------------------------------------------------------------------------*/
    /*                                                                                            */
    /* METHOD: test_delete                                                                        */
    /*                                                                                            */
    /* This method runs tests for SFDCSecurityUtils.                                              */
    /*                                                                                            */
    /*--------------------------------------------------------------------------------------------*/

    static testmethod void test_delete(){
        Account testAcc = new Account();
        testAcc.Name = 'Test Name';
        insert testAcc;
        Test.startTest();
        ESAPI.securityUtils().validatedDelete(new List<Account>{testAcc});
        System.assert([SELECT Id FROM Account WHERE Name = 'Test Name'].isEmpty());
        Test.stopTest();
    }

    /*--------------------------------------------------------------------------------------------*/
    /*                                                                                            */
    /* METHOD: test_updateEx                                                                      */
    /*                                                                                            */
    /* This method runs tests for SFDCSecurityUtils.                                              */
    /*                                                                                            */
    /*--------------------------------------------------------------------------------------------*/

    static testmethod void test_updateEx(){
        Account testAcc = new Account();
        testAcc.Name = 'Test Name';
        insert testAcc;
        testAcc.Phone = 'test';
        Test.startTest();
        try{
            SFDCSecurityUtils.crudValue = true;
            ESAPI.securityUtils().validatedUpdate(new List<Account>{testAcc});
        }catch(SFDCSecurityUtils.SFDC_FLS_Exception e){
            System.assert(e != null);
        }
        Test.stopTest();
    }

    /*--------------------------------------------------------------------------------------------*/
    /*                                                                                            */
    /* METHOD: test_insertEx                                                                      */
    /*                                                                                            */
    /* This method runs tests for SFDCSecurityUtils.                                              */
    /*                                                                                            */
    /*--------------------------------------------------------------------------------------------*/

    static testmethod void test_insertEx(){
        Account testAcc = new Account();
        testAcc.Name = 'Test Name';
        testAcc.Phone = 'test';
        Test.startTest();
        try{
            SFDCSecurityUtils.crudValue = true;
            ESAPI.securityUtils().validatedInsert(new List<Account>{testAcc});
        }catch(SFDCSecurityUtils.SFDC_FLS_Exception e){
            System.assert(e != null);
        }
        Test.stopTest();
    }

    /*--------------------------------------------------------------------------------------------*/
    /*                                                                                            */
    /* METHOD: test_insertEx2                                                                     */
    /*                                                                                            */
    /* This method runs tests for SFDCSecurityUtils.                                              */
    /*                                                                                            */
    /*--------------------------------------------------------------------------------------------*/

    static testmethod void test_insertEx2(){
        Contact testCont = new Contact();
        testCont.FirstName = 'test';
        testCont.LastName = 'test';
        Test.startTest();
        try{
            SFDCSecurityUtils.crudValue = true;
            ESAPI.securityUtils().validatedInsert(new List<Contact>{testCont});
        }catch(SFDCSecurityUtils.SFDC_CRUD_Exception e){
            System.assert(e != null);
        }
        Test.stopTest();
    }
}