package fr.ul.miashs.expression;

import fr.ul.miage.*;
import generated.fr.ul.miashs.expression.*;
import generated.fr.ul.miashs.expression.Yylex;
import generated.fr.ul.miashs.expression.ParserCup;
import fr.ul.miage.Generator;
import fr.ul.miashs.compil.arbre.TxtAfficheur;

import java.io.FileReader;
import java.io.Reader;
import java.util.Scanner;



import java.io.FileReader;

public class Main {

    public static void main(String[] args) {



        try {

            Scanner scannerChoice = new Scanner(System.in);
            String path = null;


            System.out.println("1 : example1 \n" +
                    "2 : example2 \n" +
                    "3 : example3 \n" +
                    "4 : example4 \n" +
                    "5 : example5 \n" +
                    "6 : example6 \n" +
                    "7 : example7 \n" +
                    "8 : example8 \n" +
                    "9 : example9 \n" +
                    " - Quel example vous voulez compiler ? : " );
            int choice = scannerChoice.nextInt();
            switch (choice){
                case 1 :
                    path = "samples\\e1";
                    break ;
                case 2:
                    path = "samples\\e2";
                    break;
                case 3 :
                    path = "samples\\e3.txt";
                    break;
                case 4:
                    path = "samples\\e4.txt";
                    break;
                case 5 :
                    path = "samples\\e5.txt";
                    break;
                case 6 :
                    path = "samples\\e6.txt";
                    break;
                case 7 :
                    path = "samples\\e7.txt";
                    break;
                case 8 :
                    path = "samples\\e8.txt";
                    break;
                case 9 :
                    path = "samples\\e9.txt";
                    break;

            }
            Reader file = new FileReader(path);
            Yylex scanner = new Yylex(file);
            ParserCup parser = new ParserCup(scanner);
            try {

                parser.parse();
            }catch (Exception e){
                System.out.println(e.getMessage());
            }


            System.out.println("TDS :");
//          parser.tds.generate_data();
            System.out.println("\nArbre syntaxique :");
            TxtAfficheur.afficher(parser.progNoeud);
            System.out.println("\nCode uasm :");
            Generator uasmCode = new Generator(parser.progNoeud , parser.tds);
            uasmCode.generate_data(parser.tds);
            System.out.println(uasmCode.generate_program());

            System.out.println("Terminé !");
        } catch (Exception e) {
            System.err.println(e.getMessage());

        }

    }
}