global class BMICalculator implements Callable {
    public Object call(String action, Map<String, Object> args) {
        Map<String, Object> input = (Map<String, Object>)args.get('input');
        Map<String, Object> output = (Map<String, Object>)args.get('output');
        Map<String, Object> options = (Map<String, Object>)args.get('options');
        
        return invokeMethod(action, input, output, options);
    }
    /**
    * @description: The invokeMethod is the entry point for VlocityOpenInterface implementations.
    * @param methodName The name of the method to be invoked (in this case, we'll look for 'calculateBMI').
    * @param input A Map<String, Object> containing input parameters from the Omnistudio component.
    * Expected keys: 'weightKg' (Decimal) and 'heightM' (Decimal).
    * @param output A Map<String, Object> to store the results, which will be returned to the Omnistudio component.
    * Expected key: 'CalculatedBMI' (Decimal).
    * @param options A Map<String, Object> for additional options (not used in this example).
    
    */
    public Boolean invokeMethod(
        String methodName, Map<String, Object> input,
        Map<String, Object> output, Map<String, Object> options
    ) {
        if(methodName == 'calculateBMI') {
            BMICalculator.calculateBMI(input, output, options);
        }else {
            output.put('', 'Unknown method :: ' + methodName);
        }
        return true;
    }
    
    public static void calculateBMI(
        Map<String, Object> input,
        Map<String, Object> output, Map<String, Object> options
    ) {
        try {
            Decimal weightKg;
            Decimal heightM;
            // Omnistudio might pass numbers as String or Double, cast to Decimal for precision.
            if(input.containsKey('weightKg') && input.get('weightKg') != null) {
                if(input.get('weightKg') instanceof Decimal) {
                    weightKg = (Decimal)input.get('weightKg');
                } else if(input.get('weightKg') instanceof Double) {
                    weightKg = (Decimal)input.get('weightKg');
                } else if(input.get('weightKg') instanceof String) {
                    weightKg = Decimal.valueOf((String)input.get('weightKg'));
                }
            }
            
            if(input.containsKey('heightM') && input.get('heightM') != null) {
                if(input.get('heightM') instanceof Decimal) {
                    heightM = (Decimal)input.get('heightM');
                } else if(input.get('heightM') instanceof Double) {
                    heightM = (Decimal)input.get('heightM');
                } else if(input.get('heightM') instanceof String) {
                    heightM = Decimal.valueOf((String)input.get('heightM'));
                }
            }
            
            if(heightM == null || weightKg == null || heightM == 0 || weightKg == 0 ) {
                output.put('errorMessage', 'Please provide valid non-zero height and weight for BMI calculation.');
                output.put('CalculatedBMI', null);
            } else  {
                Decimal bmi = weightKg / (heightM * heightM);
                Decimal calculatedBMI = bmi.setScale(2);
                output.put('CalculatedBMI', calculatedBMI);
                output.put('errorMessage', null);
            }
        }catch(Exception e) {
            output.put('errorMessage', 'Exception in BMICalculator invokeMethod: ' + e.getMessage() + e.getStackTraceString() + e.getLineNumber() + e.getTypeName());
        }
    }
}