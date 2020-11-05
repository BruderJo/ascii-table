' ascii table
'
' create two fies with ascii tables
' 1) square with hex and char codes
' 2) table with char codes
' save both images as bitmaps
' and end
'----------------------------------------
option base 1
option explicit
option default integer

'----------------------------------------
dim integer mul.x = mm.info(fontwidth)
dim integer mul.y = mm.info(fontheight)

dim integer cols = 800/mul.x
dim integer lines = 600/mul.y

dim integer x,y,x1,y1
dim integer c,c1

dim string k

' font to use for characters
const f = 4

dim string fname1 = "ascii-tab1-f" + str$(f) + ".bmp"
dim string fname2 = "ascii-tab2-f" + str$(f) + ".bmp"


'----------------------------------------
sub doLocate(x,y)
  if (x <= 0)     then x=0
  if (y <= 0)     then y=0
  if (x >= cols)  then x=cols-1
  if (y >= lines) then y=lines-1
  print @(x * mul.x, y * mul.y,2) "";
end sub


'----------------------------------------
'main

mode 1,8  '800x600

' when printing: black chars on white background are better
colour rgb(black),rgb(white)
cls

c1 = 32   ' we start with space
x1 = 4    ' ascii table starts at column 4, row 3
y1 = 3

' write top headline
  for x=0 to 15
    font 7
    doLocate(x1+4*x+1,y1-2): print hex$(x)
    font 1
  next x

  for y=0 to 13
    ' write left column with starting character code
    font 7
    doLocate(x1-3,y1+3*y+1): print hex$(y*16+c1)

    font 1
    for x=0 to 15
      c = c1 + 16 * y + x
      if (c < 256) then
        ' draw character at position x/y
        font f
        doLocate(x1+4*x,y1+3*y)
        print chr$(c);
        ' write charcter code right-below char
        font 7
        print @((x1+4*x)*mul.x,4+(y1+3*y+1)*mul.y) c;
      endif
    next x
  next y

' image has dimension 550x550
 save image fname1, 0,0,550,550


cls

x1 = 1: y1=1
font f

for x = 0 to 13

  for y = 0 to 15

    c = c1 + x * 16 + y
    doLocate (x1+7*x,y1+2*y)
    font 7
    print str$(c);
    font f
    doLocate (x1+7*x+3,y1+2*y)
    print chr$(c)

  next y

next x

save image fname2, 0,0,780,400


end
