public class ProcedureTools {

    public static void main(String[] args) {
        int number = 137;

        System.out.println("Procedure Demo for Number: " + number);
        System.out.println("Digit Count: " + countDigits(number));
        System.out.println("Reversed: " + reverseNumber(number));

        if (isPrime(number)) {
            System.out.println("Prime: Yes");
        } else {
            System.out.println("Prime: No");
        }
    }

    // Procedure 1: count digits of a positive number
    public static int countDigits(int value) {
        int count = 0;
        int temp = value;

        while (temp > 0) {
            temp /= 10;
            count++;
        }

        return count;
    }

    // Procedure 2: reverse digits of a positive number
    public static int reverseNumber(int value) {
        int reversed = 0;
        int temp = value;

        while (temp > 0) {
            int digit = temp % 10;
            reversed = reversed * 10 + digit;
            temp /= 10;
        }

        return reversed;
    }

    // Procedure 3: check if a number is prime
    public static boolean isPrime(int value) {
        if (value < 2) {
            return false;
        }

        for (int i = 2; i * i <= value; i++) {
            if (value % i == 0) {
                return false;
            }
        }

        return true;
    }
}