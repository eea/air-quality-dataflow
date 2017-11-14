package ro.edw;

import org.basex.core.BaseXException;
import org.basex.core.Context;
import org.basex.core.cmd.XQuery;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * Created by miahi on 6/19/2017.
 */
public class RunQuery {

    static Context context = new Context();

    public static void main(String[] args) {
        if(args.length != 2) {
            System.out.println("Usage: RunQuery query_file.xquery source_url_xml");
            return;
        }

        try {

            String query = readFile(args[0], StandardCharsets.UTF_8);

            String result = query(query, args[1]);

            System.out.println(result);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    static String query(final String query, final String sourceUrl) throws BaseXException {

        XQuery xc = new XQuery(query);
        xc.bind("source_url", sourceUrl);

        return xc.execute(context);
    }

    static String readFile(String path, Charset encoding) throws IOException
    {
        byte[] encoded = Files.readAllBytes(Paths.get(path));
        return new String(encoded, encoding);
    }
}
