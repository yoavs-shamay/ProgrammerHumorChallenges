import java.net.InetSocketAddress;

import com.sun.net.httpserver.*;
import java.util.*;
import java.io.*;

public class ServerImplementation implements Server{
    private HttpServer server;
    public ServerImplementation(int port, Map<String, ServerMethod> methods) throws IOException
    {
        server = HttpServer.create(new InetSocketAddress(port), 0);
        for (Map.Entry<String, ServerMethod> entry : methods.entrySet())
        {
            addMethod(entry.getKey(), entry.getValue());
        }
    }

    private void addMethod(String name, ServerMethod method)
    {
        server.createContext("/" + name, exchange -> {
            try
            {
                String query = exchange.getRequestURI().getQuery();
                Map<String, String> queryParams = new HashMap<String, String>();
                if (query != null)
                {
                    for(String parameter : query.split("&"))
                    {
                        String[] splitted = parameter.split("=");
                        queryParams.put(splitted[0], splitted[1]);
                    }
                }
                InputStream bodyReader = exchange.getRequestBody();
                byte[] body = bodyReader.readAllBytes();
                bodyReader.close();
                byte[] resp = method.handle(queryParams, body);
                exchange.getResponseHeaders().set("Content-Type","text/plain");
                exchange.getResponseHeaders().add("Access-Control-Allow-Origin", "*");
                exchange.sendResponseHeaders(200, resp.length);
                OutputStream respOS = exchange.getResponseBody();
                respOS.write(resp);
                respOS.close();
            }
            catch (Exception err)
            {
                exchange.getResponseHeaders().add("Access-Control-Allow-Origin", "*");
                exchange.sendResponseHeaders(500, 0);
                OutputStream respOS = exchange.getResponseBody();
                StringWriter stringWriter = new StringWriter();
                PrintWriter printWriter = new PrintWriter(stringWriter);
                err.printStackTrace(printWriter);
                printWriter.flush();
                respOS.write(stringWriter.toString().getBytes());
                respOS.close();
            }
        });
    }

    public void start()
    {
        server.start();
    }

    public void stop()
    {
        server.stop(0);
    }
}