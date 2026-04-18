// ARRAY, LOOP/NESTED LOOP, and PROCEDURE
public class SalesReport {
    public static void main(String[] args) {
        // 2D array: rows = stores, columns = daily sales
        // 3 stores, each with 4 daily sales values
        int[][] sales = {
            {12, 15, 10, 8},
            {9, 14, 11, 13},
            {16, 7, 12, 10}
        };

        // Report title
        System.out.println("\n\nWeekly Sales Report");

        // Outer loop: process one store (one row) at a time
        for (int i = 0; i < sales.length; i++) {
            // Holds the running total for the current store
            int storeTotal = 0;

            // Print store label (Store 1, Store 2, ...)
            System.out.print("Store " + (i + 1) + ": ");

            // Inner loop: process each day’s sales for the current store
            for (int j = 0; j < sales[i].length; j++) {
                // Print daily value
                System.out.print(sales[i][j] + " ");

                // Add daily value to this store's total
                storeTotal += sales[i][j];
            }

            // After inner loop ends, print total for the current store
            System.out.println("-> Total: " + storeTotal);
        }
        System.out.println("\n\n");
    }
}