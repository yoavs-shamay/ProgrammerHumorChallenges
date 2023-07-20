import java.util.*;

public interface ServerMethod
{
    public byte[] handle(Map<String, String> queryParams, byte[] bodyBytes) throws Exception;
}