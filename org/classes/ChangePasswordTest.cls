@isTest
public class ChangePasswordTest {
    @isTest static void testChangePassword() {
        System.runAs(new User(Id = UserInfo.getUserId())) {
            
        }
        Profile portalProfile = [SELECT Id FROM Profile  Limit 1];
            User newUser = new User(
                profileId = portalProfile.id,
                username = 'newUser333@yahoo.com',
                email = 'pb111@ff.com',
                emailencodingkey = 'UTF-8',
                localesidkey = 'en_US',
                languagelocalekey = 'en_US',
                timezonesidkey = 'America/Los_Angeles',
                alias='nuser',
                lastname='lastname'
            );        
            insert newUser;
            System.resetPassword(newUser.id, false);
            System.setPassword(newUser.Id, 'password11');
            PageReference result = Site.login(newUser.id, 'password11s', null);    
            System.debug('result=' + result);   
    }
}