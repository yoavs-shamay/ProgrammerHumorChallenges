import java.nio.charset.StandardCharsets;
import java.util.*;

public class GenerateFile implements ServerMethod
{
    private static GenerateFile instance = null;
    private static int binarySearch(ArrayList<Integer> arr, int val)
    {
        int low = 0, high = arr.size() - 1;
        while (low <= high)
        {
            int mid = (low + high) / 2;
            if (arr.get(mid) == val)
            {
                return mid;
            }
            else if (arr.get(mid) < val)
            {
                low = mid + 1;
            }
            else
            {
                high = mid - 1;
            }
        }
        return -1;
    }
    
    private static List<Byte> bitSetToBytes(BitSet bitSet, int bitCount)
    {
        List<Byte> res = new ArrayList<Byte>();
        byte cur = 0;
        int mul = 1;
        for (int i = 0; i < bitCount; i ++)
        {
            if (bitSet.get(i))
            {
                cur += mul;
            }
            mul *= 2;
            if (mul == (1 << 8))
            {
                res.add(cur);
                cur = 0;
                mul = 1;
            }
        }
        if (mul != 1)
        {
            res.add(cur);
        }
        return res;
    }

    private static List<Byte> intToBytes(int num)
    {
        List<Byte> res = new ArrayList<Byte>();
        byte cur = 0;
        int mul = 1;
        for (int i = 0; i < 32; i ++)
        {
            if (num % 2 == 1)
            {
                cur += mul;
            }
            num /= 2;
            mul *= 2;
            if (mul == (1 << 8))
            {
                res.add(cur);
                cur = 0;
                mul = 1;
            }
        }
        return res;
    }

    public byte[] handle(Map<String, String> queryParams, byte[] bodyBytes) throws Exception
    {
        String body = new String(bodyBytes, "utf-8");
        String creatorName = queryParams.get("creatorName");
        int date = Integer.parseInt(queryParams.get("creationDate"));
        int x = Integer.parseInt(queryParams.get("x"));
        int y = Integer.parseInt(queryParams.get("y"));
        int z = Integer.parseInt(queryParams.get("z"));
        String[] matrix = body.split(" ");
        int mul = x * y * z;
        ArrayList<Integer> divisors = Utils.getDivisors(mul);
        int lengthes = 0;
        lengthes += creatorName.length() - 1;
        lengthes *= 91;
        lengthes += binarySearch(divisors, x);
        lengthes *= 91;
        lengthes += binarySearch(divisors, y);
        BitSet header = new BitSet();
        header.set(0, 19, false);
        for (int i = 0; i < 19; i++)
        {
            if (lengthes % 2 == 1) header.set(i);
            lengthes /= 2;
        }
        header.set(19, 19 + 7 * creatorName.length(), false);
        byte[] creatorNameBytes = creatorName.getBytes(StandardCharsets.US_ASCII);
        int index = 19;
        for (int i = 0; i < creatorName.length(); i++)
        {
            byte cur = creatorNameBytes[i];
            for (int j = 0; j < 7; j++)
            {
                if (cur % 2 == 1) header.set(index);
                cur /= 2;
                index++;
            }
        }
        ArrayList<Byte> content = new ArrayList<Byte>();
        List<Byte> headerByteArr = bitSetToBytes(header, 19 + 7 * creatorName.length());
        content.addAll(headerByteArr);
        List<Byte> dateByteArr = intToBytes(date);
        content.addAll(dateByteArr);
        for (int i = 0; i < matrix.length; i++)
        {
            List<Byte> curNumberByteArr = intToBytes(Integer.parseInt(matrix[i]));
            content.addAll(curNumberByteArr);
        }
        byte[] contentByteArr = new byte[content.size()];
        for (int i = 0; i < content.size(); i++) contentByteArr[i] = content.get(i);
        return contentByteArr;
    }

    public static ServerMethod getInstance() {
        if (instance == null)
        {
            instance = new GenerateFile();
        }
        return instance;
    }
}