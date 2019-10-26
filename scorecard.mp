color field; field := (0.9, 0.9, 0.9);
numeric innings; innings := 12;

def draw_field(expr x, y, scale) =
  path wholefield;
  path diamond;
  wholefield :=
       (0, 0) -- (-2, 2) .. (0, 3.2) .. (2, 2) -- cycle;
  diamond :=
       (0, 0) -- (-1, 1) -- (0, 2) -- (1, 1) -- cycle;
  pickup pensquare scaled 0.025pt;
  draw wholefield shifted (x, y) scaled scale withcolor field;
  draw diamond shifted (x, y) scaled scale withcolor field;
enddef;

beginfig (1)
  for x = 0 step 5 until 3*innings:
    draw_field(x, 0, 0.25);
  endfor;
endfig;
bye
