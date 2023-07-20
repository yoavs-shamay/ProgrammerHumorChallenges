public class ServerMethodFactory {
    public ServerMethod createServerMethod(String type)
    {
        if (type.equals("generate"))
        {
            return GenerateFile.getInstance();
        }
        else if (type.equals("parse"))
        {
            return ParseFile.getInstance();
        }
        else
        {
            return null;
        }
    }
}
