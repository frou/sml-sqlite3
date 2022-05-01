open SQLite3

fun println s = print (s ^ "\n")

fun main () =
  let val db = openDB "testdb" true
  in
      println "Opened database";
      case execlist (buildSimpleQuery db "SELECT sqlite_version();") of
        [ ROW [TEXT version ] ] => println ("Using SQLite library version " ^ version)
      | _ => raise Fail "Cannot determine SQLite library version" ;
      if (tableExists db "pairs") then
          println "Table 'pairs' already exists"
      else
          let val q = buildQuery db "CREATE TABLE pairs (INTEGER i, TEXT S);" []
          in
              exec q;
              println "Create table"
          end;
      let val q = buildQuery db
                        "INSERT INTO pairs VALUES (?, ?);"
                        [INTEGER 10, TEXT "Hello, world!"]
      in
          exec q
      end;
      let val q = buildQuery db
                        "SELECT * FROM pairs;"
                        []
      in
          print (rowsToString (execlist q))
      end;
      closeDB db
  end handle SqlError s => println s

val _ = main ()
