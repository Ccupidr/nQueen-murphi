Const
  N: 4;

Type
  IndexRange:  1..N;
  IndexRange1:  -N..2*N;
  Status:  enum{Occupied,Unavailable,Empty};

Var
  Board:  array[IndexRange] of array[IndexRange] of Status;
  NumQueen:  0..N;
  t1:  IndexRange1;
  t2: IndexRange1;

function abs(x:IndexRange1):IndexRange1;
begin
  if x < 0 then
    return -x;
  endif;
  if x > 0 then
    return x;
  endif;
end;
procedure printBoard();
begin
    for i: IndexRange do
      for j: IndexRange do
        if (Board[i][j]) = Occupied then
          put "X";
        endif;
        if (Board[i][j] = Unavailable) then
          put "-"
        endif;
        if (Board[i][j] = Empty) then
          put "-"
        endif;
        put "  ";
      endfor;
      put "\n";
    endfor;

    put "........................";
    put "\n";
end;

ruleset i: IndexRange; j: IndexRange do
  rule "Putdown"  Board[i][j] = Empty ==>
  begin
    Board[i][j] := Occupied;
    NumQueen := NumQueen + 1;
    if NumQueen >= N  then
      printBoard();
    endif;
  --  for k : IndexRange do --标记列不可用
    --  if Board[i][k] != Occupied then
      --  Board[i][k] := Unavailable;
     -- endif;
   -- endfor;
   -- for k : IndexRange do -- 标记行不可用
     -- if Board[k][j] != Occupied then
       -- Board[k][j] := Unavailable;
      --endif;
    --endfor;
    -- 标记对角线不可用
    for n: IndexRange; m: IndexRange do
      if Board[n][j] != Occupied then --标记列不可用
        Board[n][j] := Unavailable;
      endif;
      if Board[i][m] != Occupied then -- 标记行不可用
        Board[i][m] := Unavailable;
      endif;
      t1 := n - m;
      t2 := i - j;
      if t1 < 0 then
        t1 := -t1;
      endif;
      if t2 < 0 then
        t2 := -t2; -- 保证t1 t2 是正值
      endif;
      if t1 = t2 then -- 主对角线
        if Board[n][m] != Occupied then
            Board[n][m] := Unavailable;
        endif;
      endif;
      if n+m = i+j then -- 负对角线
        if Board[n][m] != Occupied then
            Board[n][m] := Unavailable;
        endif;
      endif;
    endfor;
  endrule;
endruleset;

startstate
  begin
    for i: IndexRange; j: IndexRange do
      Board[i][j] := Empty;
    endfor;
    NumQueen := 0;
  end;

invariant
    NumQueen <= N
