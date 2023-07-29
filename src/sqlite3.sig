signature SQLITE3 = sig
  type db
  type query

  datatype value = NULL
                 | INTEGER of int
                 | REAL of real
                 | TEXT of string
                 | BLOB of Word8.word vector

  datatype row = ROW of value list

  datatype file_expectation = MUST_EXIST | MAY_NOT_EXIST

  exception SqlError of string

  val openDB : string -> file_expectation -> db
  val closeDB : db -> unit

  val buildQuery : db -> string -> value list -> query
  val buildSimpleQuery : db -> string -> query

  val exec : query -> unit
  val execlist : query -> row list

  val valueToString : value -> string
  val rowToString : row -> string
  val rowsToString : row list -> string

  val tableExists : db -> string -> bool
end

(* @todo Any API inspiration to take from these OCaml libraries?
   @body https://ocaml.org/p/sqlite3/
   @body https://ocaml.org/p/sqlite3_utils/ *)
