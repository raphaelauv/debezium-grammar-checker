# NTLR4 MySql with gradle

gradle-6.7

## 1) build project

```shell
debezium-grammar-checker$ gradle downloadParser
debezium-grammar-checker$ gradle downloadLexer
debezium-grammar-checker$ gradle generateGrammarSource
```

edit the [sql file to test](./src/main/resources/example.sql)

## 2) run the parser

the [main](./src/main/java/check/CheckFile.java) 

```shell
debezium-grammar-checker$ gradle checkRessourceFile
```