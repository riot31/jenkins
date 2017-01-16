/**
 * Created by jbUser on 23.12.2016.
 */

@isTest
public with sharing class TestIdeaTest {
    static testMethod void getTestDataTest() {
        TestIdea idea = new TestIdea();
        System.assertEquals(TestIdea.DEFAULT_TEXT, idea.testData());
    }
}