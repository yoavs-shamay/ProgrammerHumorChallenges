import java.util.*;

public class Utils {public static ArrayList<Integer> getDivisors(int number)
    {
        
        ArrayList<Integer> divisors = new ArrayList<Integer>();
        for (int i = 1; i * i <= number; i++)
        {
            if (number % i == 0)
            {
                divisors.add(i);
                if (i * i != number)
                {
                    divisors.add(number / i);
                }
            }
        }
        divisors.sort(Comparator.naturalOrder());
        return divisors;
    }
}
