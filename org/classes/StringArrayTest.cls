public class StringArrayTest {
    public static List<String> generateStringArray(Integer n) {
        List<String> result = new List<String>();
        for(Integer i = 0; i < n; i++) {
            result.add('Test ' + String.valueOf(i));
        }
        return result;
    }
}