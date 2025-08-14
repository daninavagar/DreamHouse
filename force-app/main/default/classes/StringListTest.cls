public class StringListTest {

    public static List<String> generateStringList(Integer numberString) {
        
        String name = 'Test ';
        List<String> arrayList = new List<String>();
        for(Integer i=0; i<numberString; i++) {
            arrayList.add(name + i.toString());
        }
        System.debug(arrayList);
        return arrayList;
    }
}