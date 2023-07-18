public class Main {
    public static void main(String[] args) throws Exception
    {
        Server server = new Server(8000);
        server.addMethod("generate", new GenerateFile()); //TODO singleton or something IDK
        server.addMethod("parse", new ParseFile());
        server.start();
    }
}
