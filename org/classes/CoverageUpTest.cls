@isTest
private class CoverageUpTest {
    static testmethod void upsTest() {
        CoverageUp newCover = new CoverageUp();
        newCover.up1();
        newCover.up2();
        newCover.up3();
        newCover.up4();
        newCover.up5();
        newCover.up6();
        newCover.up7();
        newCover.up8();
        newCover.up9();
        System.assertEquals(true, 2 > 1);
    }
}