import java.util.*;

public class ServerBuilder {
    private Map<String, ServerMethod> serverMethods = new HashMap<String, ServerMethod>();
    private int port;
    public ServerBuilder(int port)
    {
        this.port = port;
    }
    public void addMethod(String name, ServerMethod method)
    {
        serverMethods.put(name, method);
    }
    public Server build() throws Exception
    {
        return new ServerImplementation(port, serverMethods);
    }
}
