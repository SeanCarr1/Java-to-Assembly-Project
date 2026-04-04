public class ProcedureArrayDemo {

    public static void main(String[] args) {
        int[] values = {8, 15, 22, 5, 19};

        printArray(values);

        int sum = getSum(values);
        int max = getMax(values);

        System.out.println("Sum: " + sum);
        System.out.println("Maximum: " + max);
    }

    // Procedure 1: prints all array elements
    public static void printArray(int[] arr) {
        System.out.print("Array values: ");
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }

    // Procedure 2: computes the sum of array elements
    public static int getSum(int[] arr) {
        int total = 0;
        for (int i = 0; i < arr.length; i++) {
            total += arr[i];
        }
        return total;
    }

    // Procedure 3: finds the largest array element
    public static int getMax(int[] arr) {
        int max = arr[0];
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }
}