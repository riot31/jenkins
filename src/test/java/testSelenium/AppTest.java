package testSelenium;

import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Unit test for simple App.
 */

public class AppTest{
    @Test()
    public void sampleTest() {
        System.out.println("Hello barabashka!");
        Assert.assertEquals(true, 2 > 1);
    }

}
