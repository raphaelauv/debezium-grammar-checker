package check;

import java.io.IOException;
import java.io.InputStream;
import java.util.Scanner;

import org.antlr.v4.runtime.*;

public class CheckFile {

    public static void main(String[] args) throws IOException {

        String text = new Scanner(CheckFile.class.getResourceAsStream("/example.sql"), "UTF-8").useDelimiter("\\A").next();

        System.out.println(text);

        InputStream inputStream = CheckFile.class.getResourceAsStream("/example.sql");

        CharStream s = CharStreams.fromStream(inputStream);
        CaseChangingCharStream upper = new CaseChangingCharStream(s, true); //this mysql lexer need uppercase

        Lexer lexer = new MySqlLexer(upper);

        TokenStream tokenStream = new CommonTokenStream(lexer);

        MySqlParser parser = new MySqlParser(tokenStream);

        parser.root(); //force parsing

        System.out.println("nb errors" + parser.getNumberOfSyntaxErrors());

        System.exit(parser.getNumberOfSyntaxErrors());

    }
}
