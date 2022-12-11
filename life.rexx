/************************/
/* game of life in rexx */
/* tdwsl 2022           */
/************************/

gridw = 20
gridh = 10
gen = 0

call initgrid
call nextgen
do gi = 1 to 5
  call draw
  call nextgen
end
exit

nextgen:
  gen = gen + 1
  do i = 0 to gridw*gridh-1
    n = getneighbors(i//gridw, i%gridw)
    if n == 3 & grid.i == 0 then grid.i = -1
  end
  call sweep
  do i = 0 to gridw*gridh-1
    n = getneighbors(i//gridw, i%gridw)
    if n < 2 & grid.i == 1 then grid.i = 2
  end
  call sweep
  do i = 0 to gridw*gridh-1
    n = getneighbors(i//gridw, i%gridw)
    if n > 3 & grid.i == 1 then grid.i = 2
  end
  call sweep
  return

sweep:
  do i = 0 to gridw*gridh
    if grid.i == 2 then grid.i = 0
    if grid.i == -1 then grid.i = 1
  end
  return

alive:
  parse arg xx, yy
  ii = yy*gridw+xx
  if xx < 0 | yy < 0 | xx >= gridw | yy >= gridh then return 0
  return (grid.ii >= 1)

getneighbors:
  parse arg x, y
  n = 0
  if alive(x-1, y) then n = n + 1
  if alive(x+1, y) then n = n + 1
  if alive(x, y-1) then n = n + 1
  if alive(x, y+1) then n = n + 1
  if alive(x+1, y+1) then n = n + 1
  if alive(x+1, y-1) then n = n + 1
  if alive(x-1, y+1) then n = n + 1
  if alive(x-1, y-1) then n = n + 1
  return n

draw:
  say "gen " || gen
  do y = 0 to gridh-1
    line = ""
    do x = 0 to gridw-1
      i = y*gridw+x
      if grid.i \= 0 then
        line = line || "#"
      else
        line = line || " "
    end
    say line
  end
  return

initgrid:
  do i = 0 to gridw*gridh-1
    if random()//4 == 1 then
      grid.i = 1
    else
      grid.i = 0
  end
  return
