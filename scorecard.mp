verbatimtex \font\small    pcrb at 9pt etex

defaultfont := "pcrb";
defaultscale := 1.2;

color field_color; field_color := (.8, .8, .8);
color box_color; box_color := (.6, .6, .6);

players := 9;
innings := 12;
extra_innings := 4;
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
  % Give more vertical room for 9th inning.
  if number = 9:
    dy := inning_box_len * 2;
  else:
    dy := inning_box_len;
  fi;
  box :=
       (x, y)
    -- (x+name_box_width, y)
    -- (x+name_box_width, y-dy)
    -- (x, y-dy)
    -- cycle;
  draw box withcolor box_color;
  label(decimal number, (x+4, y-6));
enddef;

def draw_field_box_header(expr x, y, inning, extra_descr) =
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
  label.bot(decimal inning, (x + inning_box_len/2, y - inning_box_len/2));
  label.top(extra_descr, (x + inning_box_len/2, y - inning_box_len/2));
enddef;

def draw_empty_box(expr x, y, descr, extra_inning) =
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
enddef;

def draw_field_box(expr x, y) =
  draw_field(x + d/2, y - .68d);
  draw_empty_box(x, y, "", "");
enddef;

def draw_inning_summary_box(expr x, y) =
  d := inning_box_len;
  draw_empty_box(x, y, "", "");
  label(btex {\small H} etex, (x + .1d, y - .1d));
  label(btex {\small R} etex, (x + .1d, y - .35d));
  label(btex {\small E} etex, (x + .1d, y - .60d));
  label(btex {\small LOB} etex, (x + .25d, y - .85d));
enddef;

beginfig (1)
  %% Inning headers
  for i = 0 upto innings - 1:
    x := name_box_width + i * inning_box_len;
    draw_field_box_header(x, 0, i+1, "");
  endfor;

  %% Player stats headers
  string stats[];
  stats[0] := "AB";
  stats[1] := "H";
  stats[2] := "R";
  stats[3] := "RBI";
  for i = 0 upto extra_innings-1:
    x := gap + name_box_width + (i+innings)*inning_box_len;
    draw_field_box_header(x, 0, innings+i+1, stats[i]);
  endfor;

  %% Draw one row per batter
  for j = 0 upto players - 1:
    y := (j+1) * inning_box_len;
    draw_name_box(0, -y, j+1);

    for i = 0 upto innings - 1:
      x := name_box_width + i * inning_box_len;
      draw_field_box(x, -y);
    endfor;

    for i = innings upto innings + extra_innings - 1:
      x := gap + name_box_width + i * inning_box_len;
      draw_empty_box(x, -y, "", "");
    endfor
  endfor;

  %% Draw last row for inning totals
  y := (players + 1) * inning_box_len;
  for i = 0 upto innings + extra_innings - 1:
    x := name_box_width + i * inning_box_len;
    if i >= innings:
      x := x + gap;
    fi;
    draw_inning_summary_box(x, -y);
  endfor;

endfig;
bye
