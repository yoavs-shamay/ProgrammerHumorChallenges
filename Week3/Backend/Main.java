import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception
    {
        ServerMethodFactory factory = new ServerMethodFactory();
        ServerMethod generateFile = factory.createServerMethod("generate");
        ServerMethod parseFile = factory.createServerMethod("parse");
        ServerBuilder builder = new ServerBuilder(1795);
        builder.addMethod("generate", generateFile);
        builder.addMethod("parse", parseFile);
        Server server = builder.build();
        server.start();
        
    }
}
