public class ArrayAnalyzer {

    public static void main(String[] args) {
        int[] data = {18, 7, 25, 12, 30, 9};

        int min = data[0];
        int max = data[0];
        int sum = 0;
        int evenCount = 0;

        System.out.print("Array values: ");
        for (int i = 0; i < data.length; i++) {
            System.out.print(data[i] + " ");

            sum += data[i];

            if (data[i] < min) {
                min = data[i];
            }

            if (data[i] > max) {
                max = data[i];
            }

            if (data[i] % 2 == 0) {
                evenCount++;
            }
        }

        double average = (double) sum / data.length;

        System.out.println();
        System.out.println("Minimum: " + min);
        System.out.println("Maximum: " + max);
        System.out.println("Sum: " + sum);
        System.out.println("Average: " + average);
        System.out.println("Even Count: " + evenCount);
    }
}