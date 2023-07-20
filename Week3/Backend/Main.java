import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception
    {
        /*
        int[] arr = {114,194,200,191,201,233,90,173,6,39,233,184,100,1,0,0,
            0,2,0,0,0,3,0,0,0,4,0,0,0,5,0,0,
            0, 6, 0, 0, 0, 7, 0, 0, 0, 8 ,0, 0, 0, 9, 0, 0,
            0, 10, 0, 0, 0, 11, 0, 0, 0, 12, 0, 0, 0
        };
        byte[] bytes = new byte[arr.length];
        for (int i = 0; i < arr.length; i ++)
        {
            bytes[i] = (byte)arr[i];
        }
        byte[] resp = new ParseFile().handle(new HashMap<String, String>(), bytes);
        System.out.println(new String(resp, "utf-8"));
        */
        Server server = new Server(8000);
        server.addMethod("generate", new GenerateFile()); //TODO singleton or something IDK
        server.addMethod("parse", new ParseFile());
        server.start();
    }
}
