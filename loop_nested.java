public class SalesReport {
    public static void main(String[] args) {
        // Weekly sales of 3 stores for 4 days
        int[][] sales = {
            {12, 15, 10, 8},
            {9, 14, 11, 13},
            {16, 7, 12, 10}
        };

        System.out.println("Weekly Sales Report");

        for (int i = 0; i < sales.length; i++) {
            int storeTotal = 0;
            System.out.print("Store " + (i + 1) + ": ");

            for (int j = 0; j < sales[i].length; j++) {
                System.out.print(sales[i][j] + " ");
                storeTotal += sales[i][j];
            }

            System.out.println("-> Total: " + storeTotal);
        }
    }
}