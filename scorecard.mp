verbatimtex \font\small    pcrb at 9pt etex

defaultfont := "pcrb";
defaultscale := 1.2;

color field_color; field_color := (.8, .8, .8);
color box_color; box_color := (.6, .6, .6);

batters             := 9;
pitchers            := 6;
innings             := 12;
extra_innings       := 4;
inning_box_len      := 40;
pitching_box_height := inning_box_len / 2;
name_box_width      := inning_box_len * 3;
diamond_len         := inning_box_len / 5;
gap                 := 2;

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

def draw_name_box(expr x, y, dy, descr) =
  path box;
  box :=
       (x, y)
    -- (x+name_box_width, y)
    -- (x+name_box_width, y-dy)
    -- (x, y-dy)
    -- cycle;
  draw box withcolor box_color;
  label(descr, (x+4, y-6));
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
  draw_field(x + .42d, y - .7d);
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

def draw_pitcher_header(expr x, y, dx, descr) =
  path box;
  dy := pitching_box_height;
  box :=
       (x, y)
    -- (x+dx, y)
    -- (x+dx, y-dy)
    -- (x, y-dy)
    -- cycle;
  draw box withcolor box_color;
  label(descr, (x+dx/2, y-dy/2));
enddef;

def draw_pitcher_header_line(expr x, y) =
  draw_pitcher_header(x, y, name_box_width, "Pitcher");
  string pitching_labels[];
  pitching_labels[0] := "W/S/L";
  pitching_labels[1] := "IP";
  pitching_labels[2] := "H";
  pitching_labels[3] := "R";
  pitching_labels[4] := "ER";
  pitching_labels[5] := "SO";
  pitching_labels[6] := "BB";
  for i = 0 upto 6:
    draw_pitcher_header(x + name_box_width + (i*inning_box_len), y, inning_box_len, pitching_labels[i]);
  endfor;
enddef;

def draw_pitcher_line(expr x, y, number) =
  draw_name_box(x, y, pitching_box_height, decimal number);
  for i = 0 upto 6:
    draw_pitcher_header(x + name_box_width + (i*inning_box_len), y, inning_box_len, "");
  endfor;
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
  for j = 0 upto batters - 1:
    y := (j+1) * inning_box_len;
    if j = 8:
      height := 2*inning_box_len;
    else:
      height := inning_box_len;
    fi;
    draw_name_box(0, -y, height, decimal (j+1));

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
  y := (batters + 1) * inning_box_len;
  for i = 0 upto innings + extra_innings - 1:
    x := name_box_width + i * inning_box_len;
    if i >= innings:
      x := x + gap;
    fi;
    draw_inning_summary_box(x, -y);
  endfor;

  %% Pitcher box
  yoff := (batters + 2) * inning_box_len + gap;
  draw_pitcher_header_line(0, -yoff);
  for i = 1 upto pitchers:
    draw_pitcher_line(0, -yoff - i*pitching_box_height, i);
  endfor;
endfig;
bye
