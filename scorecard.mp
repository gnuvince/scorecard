color field_color; field_color := (1, 0, 0);
color box_color; box_color := (0, 0, 1);

innings := 12;
inning_box_len := 60;
diamond_len := inning_box_len / 5;

def draw_field(expr x, y) =
  path wholefield;
  path diamond;
  d := diamond_len;
  wholefield :=
       (x, y)
    -- (x-2d, y+2d)
    .. (x, y+3.2d)
    .. (x+2d, y+2d)
    -- cycle;
  diamond :=
       (x, y)
    -- (x-d, y+d)
    -- (x, y+2d)
    -- (x+d, y+d)
    -- cycle;
  pickup pensquare scaled 0.25pt;
  draw wholefield withcolor field_color;
  draw diamond withcolor field_color;
enddef;

def draw_inning_box(expr x, y) =
  path box;
  d := inning_box_len;
  box :=
       (x, y)
    -- (x, y-d)
    -- (x+d, y-d)
    -- (x+d, y)
    -- cycle;
  pickup pensquare scaled 0.5pt;
  draw_field(x + d/2, y - .68d);
  draw box withcolor box_color;
enddef;

beginfig (1)
  for i = 1 upto innings:
    x := i * inning_box_len;
    draw_inning_box(x, 0);
  endfor;
endfig;
bye
