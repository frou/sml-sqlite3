signature SQLITE3 = sig
  type db
  type query

  type bytevec = Word8.word Vector.vector

  datatype value = NULL
                 | INTEGER of int
                 | REAL of real
                 | TEXT of string
                 | BLOB of bytevec

  datatype row = ROW of value list

  exception SqlError of string;

  val opendb : string -> db
  val close : db -> unit
  val query : db -> string -> value list -> query
  val exec : query -> unit
  val execlist : query -> row list

  val valueToString : value -> string
  val rowToString : row -> string
  val rowsToString : row list -> string

  val tableExists : db -> string -> bool
end
