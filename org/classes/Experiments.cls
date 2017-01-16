public with sharing class Experiments {
    public void main() {
        List<Integer> checkedList = new List<Integer>{1,2,2,3,4,5,4,54};
        System.debug('1-' + checkedList.size());
        testSizeList(checkedList);
        System.debug('2-' + checkedList.size());
    }
    
    private void testSizeList(List<Integer> ints) {
        ints.remove(1);
    }
}