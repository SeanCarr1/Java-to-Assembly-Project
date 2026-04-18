// Topics: Array, Selection Statement, Loops
// This program analyzes an integer array by displaying all values,
// finding the minimum and maximum, computing the sum and average,
// and counting how many elements are even.
public class ArrayAnalyzer {

    public static void main(String[] args) {
        // Array initialization: sample input values to analyze.
        int[] data = {18, 7, 25, 12, 30, 9};

        // Tracking variables for computed results.
        int min = data[0];
        int max = data[0];
        int sum = 0;
        int evenCount = 0;

        // Header for array display.
        System.out.println("\n\nArray values: ");

        // Loop through each array element and update all statistics.
        for (int i = 0; i < data.length; i++) {
            // Print the current element.
            System.out.print(data[i] + " ");

            // Add current element to running sum.
            sum += data[i];

            // Selection statement: update minimum when a smaller value is found.
            if (data[i] < min) {
                min = data[i];
            }

            // Selection statement: update maximum when a larger value is found.
            if (data[i] > max) {
                max = data[i];
            }

            // Selection statement: count values divisible by 2 (even numbers).
            if (data[i] % 2 == 0) {
                evenCount++;
            }
        }

        // Compute average as a floating-point result.
        double average = (double) sum / data.length;

        // Final output block.
        System.out.println();
        System.out.println("Minimum: " + min);
        System.out.println("Maximum: " + max);
        System.out.println("Sum: " + sum);
        System.out.println("Average: " + average);
        System.out.println("Even Count: " + evenCount);
        System.out.println("\n\n");
    }
}