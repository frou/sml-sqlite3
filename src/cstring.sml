structure SQLiteCStr :> SQLITE_CSTR = struct
  val c_strlen = _import "strlen": MLton.Pointer.t -> C_Size.word;

  fun readChar ptr idx =
      Byte.byteToChar (MLton.Pointer.getWord8 (ptr, idx))

  fun toString cstr =
      if cstr = MLton.Pointer.null then
          raise Fail "null pointer passed to SQLiteCStr.toString"
      else
          CharVector.tabulate (C_Size.toInt (c_strlen cstr), readChar cstr)
end
