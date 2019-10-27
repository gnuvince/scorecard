defaultfont := "pcrb";
defaultscale := 1.2;

color field_color; field_color := (.8, .8, .8);
color box_color; box_color := (.6, .6, .6);

players := 9;
innings := 12;
inning_box_len := 40;
name_box_width := inning_box_len * 3;
diamond_len := 0.2 * inning_box_len;
gap := 2;

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

def draw_name_box(expr x, y, number) =
  path box;
  box :=
       (x, y)
    -- (x+name_box_width, y)
    -- (x+name_box_width, y-inning_box_len)
    -- (x, y-inning_box_len)
    -- cycle;
  draw box withcolor box_color;
  label(decimal number, (x+4, y-6));
enddef;

def draw_inning_box_header(expr x, y, inning) =
  path box;
  d := inning_box_len;
  box :=
    (x, y)
    -- (x, y-d)
    -- (x+d, y-d)
    -- (x+d, y)
    -- cycle;
  pickup pensquare scaled 0.5pt;
  draw box withcolor box_color;
  label(decimal inning, (x + inning_box_len/2, y - inning_box_len/2));
enddef;

def draw_summary_box(expr x, y, descr) =
  path box;
  d := inning_box_len;
  box :=
    (x, y)
    -- (x, y-d)
    -- (x+d, y-d)
    -- (x+d, y)
    -- cycle;
  pickup pensquare scaled 0.5pt;
  draw box withcolor box_color;
  label(descr, (x + d/2, y - d/2));
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
  %% Inning headers
  for i = 0 upto innings - 1:
    x := name_box_width + i * inning_box_len;
    draw_inning_box_header(x, 0, i+1);
  endfor;

  %% Player stats headers
  string stats[];
  stats[0] := "AB";
  stats[1] := "H";
  stats[2] := "R";
  stats[3] := "RBI";
  for i = 0 upto 3:
    draw_summary_box(gap + name_box_width + (i+innings)*inning_box_len, 0, stats[i]);
  endfor;

  for j = 0 upto players - 1:
    y := (j+1) * inning_box_len;
    draw_name_box(0, -y, j+1);

    for i = 0 upto innings - 1:
      x := name_box_width + i * inning_box_len;
      draw_inning_box(x, -y);
    endfor;

    for i = innings upto innings + 3:
      x := gap + name_box_width + i * inning_box_len;
      draw_summary_box(x, -y, "");
    endfor

  endfor;
endfig;
bye
