public class BMICalculator {
    public static void main(String[] args) {
        int[] weights = {50, 70, 90, 60, 120};
        int height = 170;
        System.out.println("BMI Classification:");
        for (int i = 0; i < weights.length; i++) {
            double bmi = weights[i] / (height * height / 10000.0);
            String category;
            if (bmi >= 30) {
                category = "Obese";
            } else if (bmi >= 25) {
                category = "Overweight";
            } else if (bmi >= 18.5) {
                category = "Normal";
            } else {
                category = "Underweight";
            }
            System.out.println("Weight: " + weights[i] + "kg -> BMI: " + category);
        }
    }
}

