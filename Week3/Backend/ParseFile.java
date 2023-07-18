import java.util.*;

public class ParseFile implements Server.ServerMethod
{
    private static int intFromBits(byte[] arr, int start, int bitOffset, int lengthInBits)
    {
        int res = 0;
        int curIndex = start;
        int curBit = bitOffset;
        int mul = 1;
        for (int i = 0; i < lengthInBits; i++)
        {
            if (curBit == 8)
            {
                curBit = 0;
                curIndex++;
            }
            if ((arr[curIndex] & (1 << curBit)) != 0)
            {
                res += mul;
            }
            mul *= 2;
            curBit++;
        }
        return res;
    }

    private static int intFromBytes(byte[] arr, int start)
    {
        return intFromBits(arr, start, 0, 32);
    }

    public byte[] handle(Map<String, String> queryParams, byte[] bodyBytes) throws Exception
    {
        int header = intFromBits(bodyBytes, 0,0, 19);
        int yP = header % 91;
        header /= 91;
        int xP = header % 91;
        header /= 91;
        int creatorNameLength = header + 1;
        StringBuilder creatorNameBuilder = new StringBuilder();
        int index = 19;
        for (int i = 0; i < creatorNameLength; i++)
        {
            int curChar = intFromBits(bodyBytes, index / 8, index % 8, 7);
            creatorNameBuilder.append((char)curChar);
            index += 7;
        }
        String creatorName = creatorNameBuilder.toString();
        index = (int)Math.ceil(index / 8.0);
        int date = intFromBytes(bodyBytes, index);
        index += 4;
        StringBuilder matrixBuilder = new StringBuilder();
        for (int i = index; i < bodyBytes.length - 3; i += 4)
        {
            int curNumber = intFromBytes(bodyBytes, i);
            matrixBuilder.append(curNumber);
            matrixBuilder.append(" ");
        }
        matrixBuilder.deleteCharAt(matrixBuilder.length() - 1);
        String matrix = matrixBuilder.toString();
        int size = bodyBytes.length - (int)Math.ceil((19 + creatorNameLength * 7) / 8.0) - 4;
        size /= 4;
        ArrayList<Integer> divisors = Utils.getDivisors(size);
        int x = divisors.get(xP);
        int y = divisors.get(yP);
        int z = (size / x) / y;
        String res = String.valueOf(date) + " " + creatorName + " " + String.valueOf(x) + " " + String.valueOf(y) + " " + String.valueOf(z) + " " + matrix;
        return res.getBytes("utf-8");
    }
}